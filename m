Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbUKEUBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbUKEUBV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Nov 2004 15:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbUKEUBU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Nov 2004 15:01:20 -0500
Received: from sanosuke.troilus.org ([66.92.173.88]:48531 "EHLO
	sanosuke.troilus.org") by vger.kernel.org with ESMTP
	id S261197AbUKEUAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Nov 2004 15:00:39 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: davids@webmaster.com, jp@enix.org, linux-kernel@vger.kernel.org
Subject: Re: Possible GPL infringement in Broadcom-based routers
References: <200411051820.iA5IKgT28261@adam.yggdrasil.com>
From: Michael Poole <mdpoole@troilus.org>
Date: 05 Nov 2004 15:00:37 -0500
In-Reply-To: <200411051820.iA5IKgT28261@adam.yggdrasil.com>
Message-ID: <87is8kukuy.fsf@sanosuke.troilus.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam J. Richter writes:

> Michael Poole writes:
>
> >Combining GPLed works with GPL-incompatible works violates the GPL if
> >you distribute the result; the GPL allows one to make that kind of
> >combination for one's own use.  Go read the GPL more closely.
> 
> 	There are US court cases that have established that copying
> into RAM is copying for the purposes of copyright.  Also, I'd have
> to say that loading a module into a kernel is modification.

Whether those actions constitute protected copying or modification is
irrelevant[1].  Section 2 of the GPL is quite clear that it only
requires GPL licensing of works that one distributes.  It allows me to
copy, modify and otherwise create derivative works; the requirement to
license those works under the GPL applies when I distribute them.

(Because Broadcom does distribute those derivative works contrary to
the GPL, I suspect they are directly infringing.  My main point is
that your argument about users infringing the GPL is wrong, and
therefore so is the argument about contributory infringement.)

[1]- If you mean cases I think you do, they were the inspiration for
Title III of the DMCA, which added the repair and maintenance
exceptions in 17 USC 117(c) and (d).

> 	My understanding is that the FSF was able to get Next Computer
> to release its Objective C modules for gcc, over just this sort of
> "user does the link" issue.

My understanding is that the Objective C front-end was a derivative of
the gcc back-end for reasons unrelated to who did the linking, and
that was what convinced NeXT.

Michael Poole
