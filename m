Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264046AbRFERRR>; Tue, 5 Jun 2001 13:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264047AbRFERRH>; Tue, 5 Jun 2001 13:17:07 -0400
Received: from mx3out.umbc.edu ([130.85.253.53]:26575 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S264046AbRFERRD>;
	Tue, 5 Jun 2001 13:17:03 -0400
Date: Tue, 5 Jun 2001 13:16:58 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: <slurn@verisign.com>
cc: Keith Owens <kaos@ocs.com.au>, <linux-kernel@vger.kernel.org>,
        <kdb@oss.sgi.com>
Subject: Re: strange network hangs using kdb
In-Reply-To: <200106051710.KAA03726@slurndal-lnx.verisign.com>
Message-ID: <Pine.SGI.4.31L.02.0106051315370.11523908-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Jun 2001 slurn@verisign.com wrote:

> Might the machine running kdb also be acting as a gateway or router
> for the other boxen?  This would account for the lack of connectivity.

Nope. No such luck. I _wish_ it was that easy. :)

As for it being a network problem, it is -- and completely reproducable.
Fire up kdb, and no-one receives packets. Otherwise, no problems occur --
even when both systems are under heavy network load.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

