Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262317AbSI3QzA>; Mon, 30 Sep 2002 12:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262336AbSI3QzA>; Mon, 30 Sep 2002 12:55:00 -0400
Received: from 2-225.ctame701-1.telepar.net.br ([200.193.160.225]:53424 "EHLO
	2-225.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S262317AbSI3Qy7>; Mon, 30 Sep 2002 12:54:59 -0400
Date: Mon, 30 Sep 2002 13:59:56 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: procps-list@redhat.com
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [ANNOUNCE] procps 2.0.9
Message-ID: <Pine.LNX.4.44L.0209301357500.22735-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		Procps 2.0.9
		30 Sep 2002


Procps is the package containing various system monitoring tools, like
ps, top, vmstat, free, kill, sysctl, uptime and more.  After a long
period of inactivity procps maintenance is active again and suggestions,
bugreports and patches are always welcome on the procps list.

The plan is to release a procps 2.1.0 around the time the 2.6.0 kernel
comes out, with regular releases until then. Code cleanups and all kinds
of enhancements are welcome.


You can download procps 2.0.9 from:

	http://surriel.com/procps/procps-2.0.9.tar.bz2

If you have feedback (or patches) for the procps team, feel free to
mail us at:

	procps-list@redhat.com


NEWS for version 2.0.9 of procps

* harvest numerous patches from Debian procps  (Rik van Riel)
* source code Lindented on popular request  (Rik van Riel)
* support for printing the current CPU of a process  (Robert Love)
* Add the pmap program  (Andy Isaacson)
* On large SMP systems top had no screen space left for processes
  because of the CPU stats. Allow users to [C]ollapse the CPU
  stats into a single line.  (Rik van Riel)
* More code cleanups  (Roberto Nibali, Rik van Riel)
* Make all tools display the standard version  (Rik van Riel)
* VERSION got lost in the cleanups  (Roberto Nibali, Rik van Riel)
* Fix pgrep/pkill usage message confusion  (Roberto Nibali)


