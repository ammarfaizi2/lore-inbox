Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270537AbTGSU4W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jul 2003 16:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270538AbTGSU4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jul 2003 16:56:22 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:49596 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S270537AbTGSU4V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jul 2003 16:56:21 -0400
Date: Sat, 19 Jul 2003 18:07:42 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: lkml <linux-kernel@vger.kernel.org>
Cc: Mark Cooke <mpc@star.sr.bham.ac.uk>
Subject: pre6 oddity (fwd)
Message-ID: <Pine.LNX.4.55L.0307191805200.11090@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Bogus.

---------- Forwarded message ----------
Date: 19 Jul 2003 08:54:55 +0100
From: Mark Cooke <mpc@star.sr.bham.ac.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: pre6 oddity

Hi Marcelo,

On two of my machines running pre6, I am seeing top report very odd
priorities for two kernel tasks:

  PID USER     PRI  NI  SIZE  RSS SHARE STAT %CPU %MEM   TIME CPU
COMMAND

    8 root     18446744073709551615 -20     0    0     0 SW<   0.0
0.0   0:00   0 mdrecoveryd
   16 root     18446744073709551615 -20     0    0     0 SW<   0.0
0.0   0:00   0 raid1d


Something related to the scheduling changes going on ?

(RedHat 9 base system)

Mark

-- 
Mark Cooke <mpc@star.sr.bham.ac.uk>
