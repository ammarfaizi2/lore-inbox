Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWAKFaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWAKFaL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 00:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWAKFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 00:30:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:25063 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751375AbWAKFaK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 00:30:10 -0500
Date: Tue, 10 Jan 2006 21:15:32 -0800
From: Greg KH <greg@kroah.com>
To: Ben Collins <bcollins@ubuntu.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 05/15] pci: Add Toshiba PSA40U laptop to ohci1394 quirk dmi table.
Message-ID: <20060111051532.GA3455@kroah.com>
References: <0ISL00NV994G1L@a34-mta01.direcway.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0ISL00NV994G1L@a34-mta01.direcway.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 04, 2006 at 04:59:59PM -0500, Ben Collins wrote:
> Signed-off-by: Ben Collins <bcollins@ubuntu.com>
> 
> ---
> 
>  arch/i386/pci/fixup.c |    7 +++++++

Hm, you might want to cc: the maintainers of the sections you are
patching to make sure they see the change you are making.

Care to respin this against the latest -git tree and resend it to me?

thanks,

greg k-h
