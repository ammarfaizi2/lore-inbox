Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316909AbSGIQiS>; Tue, 9 Jul 2002 12:38:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316970AbSGIQiR>; Tue, 9 Jul 2002 12:38:17 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:51936 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S316909AbSGIQiO>; Tue, 9 Jul 2002 12:38:14 -0400
Date: Tue, 9 Jul 2002 10:40:56 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: compile error in init/main.c
Message-ID: <Pine.LNX.4.44.0207091039260.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What's this compile error supposed to mean?

init/main.c: In function `rest_init':
init/main.c:325: stray '\' in program
init/main.c: In function `init':
init/main.c:499: stray '\' in program

Both lines are unlock_kernel()

.config is configallmod, gcc is 3.0.4

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

