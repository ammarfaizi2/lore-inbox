Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262193AbSJFUIU>; Sun, 6 Oct 2002 16:08:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262192AbSJFUIU>; Sun, 6 Oct 2002 16:08:20 -0400
Received: from netlx010.civ.utwente.nl ([130.89.1.92]:65240 "EHLO
	netlx010.civ.utwente.nl") by vger.kernel.org with ESMTP
	id <S262193AbSJFUIT>; Sun, 6 Oct 2002 16:08:19 -0400
Date: Sun, 6 Oct 2002 22:13:51 +0200 (CEST)
From: Gcc k6 testing account <caligula@cam029208.student.utwente.nl>
To: Thomas Molina <tmolina@cox.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Report Status
In-Reply-To: <Pine.LNX.4.44.0210050924470.10630-100000@dad.molina>
Message-ID: <Pine.LNX.4.44.0210062210310.22565-100000@cam029208.student.utwente.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Thomas Molina wrote:

> 
> The following status report update can be found at:
> http://members.cox.net/tmolina/kernprobs/021004-status.html
> 
> The latest update can be found at:
> http://members.cox.net/tmolina/kernprobs/status.html
> 
> 
>    Notes:
>      * Items  marked  closed  or probable fix will be deleted after Linus
>        issues the next patch version
>      * Numerous  people  are reporting oops on boot in 2.5.39. It appears
>        the problems are all caused by a bug in isapnp initialization. The
>        fix is either to disable isapnp or patch in a workaround.
> 
> -------------------------------------------------------------------------
>    fix available          02 Oct 2002 loadlin boot problem
>   10. http://marc.theaimsgroup.com/?l=linux-kernel&m=103351848816172&w=2
> 
> I'm going to delete this one when Linus issues 2.5.41 unless someone 
> objects.

Someone posted a link to an updated version of loadlin. The updated 
version works with 2.5.32+ kernels. So I can confirm the available fix.
So either the updated version of loadlin or the linld bootloader will fix 
this problem.

Greetz Mu




