Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261530AbVEFEcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbVEFEcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 00:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262222AbVEFEcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 00:32:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:53407 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261530AbVEFEcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 00:32:02 -0400
Date: Thu, 5 May 2005 21:30:49 -0700
From: Greg KH <greg@kroah.com>
To: Kumar Gala <kumar.gala@freescale.com>
Cc: Deepak Saxena <dsaxena@plexity.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit resources?
Message-ID: <20050506043049.GB13207@kroah.com>
References: <20050310173522.GA17285@kroah.com> <7ade2efc25e965ee53a271cd599ff5ae@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7ade2efc25e965ee53a271cd599ff5ae@freescale.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2005 at 11:12:34PM -0500, Kumar Gala wrote:
> On Mar 10, 2005, at 11:35 AM, Greg KH wrote:
> 
> >On Thu, Mar 10, 2005 at 01:46:10AM -0600, Kumar Gala wrote:
> > > Greg,
> > >
> >> I was wondering what the state of the change to 64-bit resources was?
> >
> >On hold till I get the time to fix all of the kernel tree up due to the
> > changes required.
> >
> >Unless someone else wants to volunteer to do the work :)
> 
> I'll like to see if we can get things into a state to have this ready 
> for 2.6.13.  Do you have a tree around with the changes in it?  Do you 
> have a sense of what work needs to be done.  If you give me some 
> direction on things needing fixing I can start taking a look and 
> working on patches.

Sorry, no tree, but here is the patch and info:
	http://www.kernel.org/pub/linux/kernel/people/gregkh/pci/2.6/2.6.11-rc3/bk-resource*

I do have a few other patches laying around, but that should be a good
start :)

Good luck,

greg k-h
