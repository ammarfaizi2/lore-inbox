Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751118AbVJ2DUF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751118AbVJ2DUF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 23:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVJ2DUF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 23:20:05 -0400
Received: from mail.kroah.org ([69.55.234.183]:5014 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751118AbVJ2DUC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 23:20:02 -0400
Date: Fri, 28 Oct 2005 20:19:29 -0700
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rolandd@cisco.com>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH/v2] PCI: add pci_find_next_capability()
Message-ID: <20051029031929.GA26439@kroah.com>
References: <52u0f1p3c9.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52u0f1p3c9.fsf@cisco.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2005 at 05:35:34PM -0700, Roland Dreier wrote:
> Greg,
> I think you silently dropped the patch below.  This is the new version
> that incorporates Matthew Wilcox's suggestion to avoid duplicating the
> loop that iterates through capabilities.

I did, sorry.  I'll add it to my queue.

greg k-h
