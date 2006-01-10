Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932274AbWAJCvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932274AbWAJCvu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 21:51:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWAJCvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 21:51:50 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:50562 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932274AbWAJCvt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 21:51:49 -0500
Date: Mon, 9 Jan 2006 21:51:18 -0500 (EST)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@gandalf.stny.rr.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: mingo@elte.hu, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mutex subsystem, semaphore to completion: SX8
In-Reply-To: <43C31F08.304@pobox.com>
Message-ID: <Pine.LNX.4.58.0601092148190.22299@gandalf.stny.rr.com>
References: <200601100207.k0A27B4J007573@hera.kernel.org> <43C31F08.304@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 9 Jan 2006, Jeff Garzik wrote:

> Linux Kernel Mailing List wrote:
> > tree c45749fcb6f8f22d9e2666135b528c885856aaed
> > parent 7892f2f48d165a34b0b8130c8a195dfd807b8cb6
> > author Steven Rostedt <rostedt@goodmis.org> Tue, 10 Jan 2006 07:59:26 -0800
> > committer Ingo Molnar <mingo@hera.kernel.org> Tue, 10 Jan 2006 07:59:26 -0800
> >
> > [PATCH] mutex subsystem, semaphore to completion: SX8
> >
> > change SX8 semaphores to completions.
> >
> > Signed-off-by: Ingo Molnar <mingo@elte.hu>
>
> Please at least CC the maintainer (me) _sometime_ before pushing
> upstream, when you modify a driver...
>

My appologies, it wasn't intended.  I changed a few files from semaphores
to completions and sent them off to Ingo to work on.  I tried to always CC
the maintainers that are either listed in the file or in MAINTAINERS.  I
must have missed you (and probably others).

This was by no means something to circumvent the maintainer, it was just
an oversight.

-- Steve

