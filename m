Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318252AbSHDW0B>; Sun, 4 Aug 2002 18:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318253AbSHDW0B>; Sun, 4 Aug 2002 18:26:01 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:7552 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S318252AbSHDWZ5>; Sun, 4 Aug 2002 18:25:57 -0400
Date: Mon, 05 Aug 2002 00:37:11 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Just cosmethic but...
Message-ID: <3D4DAC97.mailYI11WJXY@viadomus.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :)

    The output of 'cat /proc/meminfo' is ugly by today standards,
since is very frequent having more than 99 Mb of RAM and the current
meminfo just supports 8 digits before outputting ugly tabulations.

    So, how about raising that 8 digits to at least 10, thus allowing
pretty tabulations up to 9 Gb of RAM?

    If it will be accepted I can make the patch against the current
-ac kernel, for example. I know that is only a cosmethic change, but
I use meminfo a lot and I would like to see a good tabulation ;))

    Raúl
