Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262006AbUKPP4s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262006AbUKPP4s (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 10:56:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262012AbUKPP4r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 10:56:47 -0500
Received: from mail.kroah.org ([69.55.234.183]:41146 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262006AbUKPP4q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 10:56:46 -0500
Date: Tue, 16 Nov 2004 07:56:14 -0800
From: Greg KH <greg@kroah.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Cleanup PCI power states
Message-ID: <20041116155613.GA1309@kroah.com>
References: <20041116130445.GA10085@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041116130445.GA10085@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 02:04:45PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is step 0 before adding type-safety to PCI layer... It introduces
> constants and uses them to clean driver up. I'd like this to go in
> now, so that I can convert drivers during 2.6.10... Please apply,

The tree is in "bugfix only" mode right now.  Changes like this need to
wait for 2.6.10 to come out before I can send it upward.

So, care to hold on to it for a while?  Or I can add it to my "to apply
after 2.6.10 comes out" tree, which will mean it will end up in the -mm
releases till that happens.

thanks,

greg k-h
