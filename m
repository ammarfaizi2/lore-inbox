Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262991AbUKXXtS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262991AbUKXXtS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbUKXXr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:47:59 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:38789 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262895AbUKXXor (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:44:47 -0500
Date: Wed, 24 Nov 2004 15:40:57 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041124234057.GF4649@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz> <20041116155613.GA1309@kroah.com> <20041117120857.GA6952@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041117120857.GA6952@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 01:08:58PM +0100, Pavel Machek wrote:
> Hi!
> 
> > > This is step 0 before adding type-safety to PCI layer... It introduces
> > > constants and uses them to clean driver up. I'd like this to go in
> > > now, so that I can convert drivers during 2.6.10... Please apply,
> > 
> > The tree is in "bugfix only" mode right now.  Changes like this need to
> > wait for 2.6.10 to come out before I can send it upward.
> > 
> > So, care to hold on to it for a while?  Or I can add it to my "to apply
> > after 2.6.10 comes out" tree, which will mean it will end up in the -mm
> > releases till that happens.
> 
> I think I'd prefer visibility of "to apply after 2.6.10" tree... Thanks,

Care to resend this, I seem to have lost them :(

thanks,

greg k-h
