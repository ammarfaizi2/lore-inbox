Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317954AbSGLArj>; Thu, 11 Jul 2002 20:47:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317956AbSGLAri>; Thu, 11 Jul 2002 20:47:38 -0400
Received: from p50886A23.dip.t-dialin.net ([80.136.106.35]:59268 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317954AbSGLArh>; Thu, 11 Jul 2002 20:47:37 -0400
Date: Thu, 11 Jul 2002 18:50:16 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Stevie O <oliver@klozoff.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: HZ, preferably as small as possible
In-Reply-To: <5.1.0.14.2.20020711201602.022387b0@whisper.qrpff.net>
Message-ID: <Pine.LNX.4.44.0207111847440.30529-100000@hawkeye.luckynet.adm>
X-Location: Potsdam; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 11 Jul 2002, Stevie O wrote:
> Why must HZ be the same as 'interrupts per second'?

s/interrupts/scheduler calls/

But what exactly does this question mean to be? I don't fully understand. 
We define HZ to have an interval for the calls of the scheduler. That's 
why it is the number of scheduler calls per second, because that's what it 
was invented to be.

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

