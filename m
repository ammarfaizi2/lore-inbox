Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbVFMRoH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbVFMRoH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 13:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261157AbVFMRoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 13:44:07 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:44042 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261155AbVFMRoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 13:44:05 -0400
Date: Mon, 13 Jun 2005 10:43:55 -0700
From: Greg KH <gregkh@suse.de>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Patch series to remove devfs [00/22]
Message-ID: <20050613174355.GB12517@suse.de>
References: <20050611074327.GA27785@kroah.com> <1118616273l.18059l.0l@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118616273l.18059l.0l@werewolf.able.es>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 12, 2005 at 10:44:33PM +0000, J.A. Magallon wrote:
> 
> On 06.11, Greg KH wrote:
> > As everyone knows[1], devfs is going to be removed from the kernel soon.
> > To accomplish this, here is a series of patches (22 in all) that do just
> > that.  Surprisingly enough, devfs was almost everywhere in the kernel,
> > that's why it takes so many patches :)
> > 
> 
> You missed this for -mm, do not know if they apply to mainline:

This patch series was not for -mm, as my comments stated :)

But thanks for the patch anyway.

greg k-h
