Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262030AbTKQVhL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTKQVhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 16:37:11 -0500
Received: from fw.osdl.org ([65.172.181.6]:1478 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262030AbTKQVfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 16:35:53 -0500
Date: Mon, 17 Nov 2003 13:30:40 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: drepper@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] POSIX message queues - syscalls & SIGEV_THREAD
Message-Id: <20031117133040.59dbc840.rddunlap@osdl.org>
In-Reply-To: <20031117211403.GB20118@mail.shareable.org>
References: <Pine.GSO.4.58.0311161546260.25475@Juliusz>
	<20031117064832.GA16597@mail.shareable.org>
	<Pine.GSO.4.58.0311171236420.29330@Juliusz>
	<3FB91C54.5020905@redhat.com>
	<20031117211403.GB20118@mail.shareable.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003 21:14:03 +0000 Jamie Lokier <jamie@shareable.org> wrote:

| Ulrich Drepper wrote:
| > Yes, this would be possible if FUTEX_FD wouldn't be useless as it is
| > implemented today (see the futex paper I announced here recently). 
| 
| Which futex paper?

http://people.redhat.com/drepper/futex.pdf

--
~Randy
MOTD:  Always include version info.
