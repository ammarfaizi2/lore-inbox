Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262923AbUCLVi6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 16:38:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262990AbUCLVi6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 16:38:58 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:16845 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S262923AbUCLVi5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 16:38:57 -0500
Date: Fri, 12 Mar 2004 22:38:55 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Timothy Miller <miller@techsource.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel 'simulator' and wave-form analysis tool?
Message-ID: <20040312213855.GA8832@MAIL.13thfloor.at>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <4048B36E.8000605@techsource.com> <Pine.LNX.4.53.0403051253220.32349@chaos> <4048CC7F.4070009@techsource.com> <200403061113.i26BDHrs000517@81-2-122-30.bradfords.org.uk> <404A900B.4020105@matchmail.com> <404CA064.6040108@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <404CA064.6040108@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 08, 2004 at 11:33:40AM -0500, Timothy Miller wrote:
> 
> 
> Mike Fedyk wrote:
> >John Bradford wrote:
> >
> >>>I must have been unclear.  I was not suggesting adding hardware.  I 
> >>>was suggesting that we could run Linux under Bochs, which is a 
> >>>software x86 emulator.  Being what it is, hooks can be added to track 
> >>>"cpu activity" is it occurs within the emulator.  This is all a 
> >>>simulation.  The key idea I was suggesting was to log processor 
> >>>activity (of the emulator) and develop a viewer program which would 
> >>>help people visualize the activity.

sounds good and useful to me, have a look at 
other simulators/emulators too, for example
I use QEMU[1] to test linux kernels, because
it is much simpler and faster than Bochs (YMMV)

best,
Herbert

> If your stack gets hosed by a bug, a simulator with a complete history 
> of memory writes will help you discover the problem.
> 
> I know nothing about Valgrind.

[1] http://fabrice.bellard.free.fr/qemu/

