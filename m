Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751226AbVKUWoy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751226AbVKUWoy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 17:44:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbVKUWoy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 17:44:54 -0500
Received: from mail.kroah.org ([69.55.234.183]:63385 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751220AbVKUWox (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 17:44:53 -0500
Date: Mon, 21 Nov 2005 14:44:38 -0800
From: Greg KH <greg@kroah.com>
To: David Fox <david.fox@linspire.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-rc2 pci_ids.h cleanup is a pain
Message-ID: <20051121224438.GA18966@kroah.com>
References: <438249CB.8050200@linspire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <438249CB.8050200@linspire.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2005 at 02:27:23PM -0800, David Fox wrote:
> I'm sure I'm not the only person that applies patches to the kernel that 
> use some of the 500 plus PCI IDS eliminated from pci_ids.h by rc2.  I 
> would like to see the PCI ids that were removed simply because the don't 
> occur in the main kernel source restored.  Is there a rationale for 
> removing them that I'm not aware of?

They were not being used.  Why would you want them in there?

And, what pending patches do you have that patched this file?  Is there
a reason you have not submitted it for inclusion?

thanks,

greg k-h
