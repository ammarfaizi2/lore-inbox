Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272918AbTHFXJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273019AbTHFXJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:09:23 -0400
Received: from mail.kroah.org ([65.200.24.183]:1425 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S272918AbTHFXJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:09:21 -0400
Date: Wed, 6 Aug 2003 16:09:19 -0700
From: Greg KH <greg@kroah.com>
To: Alex Williamson <alex_williamson@hp.com>
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial 2.4/2.6 PCI name change/addition
Message-ID: <20030806230919.GB8187@kroah.com>
References: <3F315CDD.12EB17FE@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F315CDD.12EB17FE@hp.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 01:54:05PM -0600, Alex Williamson wrote:
> 
>    This patch renames the PCI-X adapter found in HP zx1 and sx1000
> ia64 systems to something more generic and descriptive.  It also
> adds an ID for the PCI adapter used in sx1000.  Patches against
> 2.4.21+ia64 and 2.6.0-test2+ia64 attached.  Thanks,

I've applied the 2.6 patch to my trees and will send it on to Linus in a
few days, thanks.

greg k-h
