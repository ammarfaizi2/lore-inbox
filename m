Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130450AbRCTP2J>; Tue, 20 Mar 2001 10:28:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130452AbRCTP2A>; Tue, 20 Mar 2001 10:28:00 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:45747 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S130450AbRCTP1u>; Tue, 20 Mar 2001 10:27:50 -0500
Message-ID: <3AB776CB.9FCDA025@inet.com>
Date: Tue, 20 Mar 2001 09:27:07 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: Re: gettimeofday question
In-Reply-To: <200103192344.XAA02107@raistlin.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> This problem has a non-trivial solution, and I think whoever originally
> wrote the x86 do_gettimeofday code decided that it wasn't worth finding
> a solution to it.

So are you going to use the x86 solution and not worry about the >10ms
problem for now?  The x86 is an improvement over the current situation
(at least on ebsa285).  Or do you have something else in mind?

Eli
-----------------------.           Rule of Accuracy: When working toward
Eli Carter             |            the solution of a problem, it always 
eli.carter(at)inet.com `------------------ helps if you know the answer.
