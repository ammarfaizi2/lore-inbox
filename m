Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262595AbSJHNaQ>; Tue, 8 Oct 2002 09:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262602AbSJHNaQ>; Tue, 8 Oct 2002 09:30:16 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:8907 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S262595AbSJHNaO>; Tue, 8 Oct 2002 09:30:14 -0400
Date: Tue, 8 Oct 2002 10:35:40 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: procps-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] procps 2.0.10
Message-ID: <Pine.LNX.4.44L.0210081034360.1909-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

		Procps 2.0.10
		8 Oct 2002


Procps is the package containing various system monitoring tools, like
ps, top, vmstat, free, kill, sysctl, uptime and more.  After a long
period of inactivity procps maintenance is active again and suggestions,
bugreports and patches are always welcome on the procps list.

The plan is to release a procps 2.1.0 around the time the 2.6.0 kernel
comes out, with regular releases until then. Code cleanups and all kinds
of enhancements are welcome.


You can download procps 2.0.10 from:

	http://surriel.com/procps/procps-2.0.10.tar.bz2

If you have feedback (or patches) for the procps team, feel free to
mail us at:

	procps-list@redhat.com


NEWS for version 2.0.10 of procps

* fix memory size overflow in ps (Anton Blanchard)
* add iowait statistics to top (Rik van Riel)
* update top help text (Denis Vlasenko)
* fix jumpy percentage formatting in top (Denis Vlasenko)
* fix some newer gcc compiler warnings (Denis Vlasenko)
* by default, do not show threads in ps or top - you can use the
  `-m' flag in ps or the `H' key in top to show them (Robert Love)



Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

