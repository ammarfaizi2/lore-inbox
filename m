Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288114AbSAMUcQ>; Sun, 13 Jan 2002 15:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288116AbSAMUcH>; Sun, 13 Jan 2002 15:32:07 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:685 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288114AbSAMUbv>; Sun, 13 Jan 2002 15:31:51 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch] O(1) scheduler, -G1, 2.5.2-pre10, 2.4.17 (fwd)
Date: Sun, 13 Jan 2002 21:30:33 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Ingo Molnar <mingo@elte.hu>, Robert Love <rml@tech9.net>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020113203157Z288114-13997+4421@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty wrote:
> Agree.  Anyone who really has 3 CPU hogs on a 2 CPU machine, *and*
> never runs two more tasks to perturb the system, *and* notices that
> one runs twice the speed of the other two, *and* cares about fairness
> (ie. not RC5 etc), feel free to Email abuse to me.  Not Ingo, he has
> real work to do 8)

Or buy a third CPU...;-)

Regards,
	Dieter

BTW Not meant as flaming.
--
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
