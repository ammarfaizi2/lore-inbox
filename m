Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261418AbSIZRL7>; Thu, 26 Sep 2002 13:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261419AbSIZRL7>; Thu, 26 Sep 2002 13:11:59 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:45752 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261418AbSIZRL4>; Thu, 26 Sep 2002 13:11:56 -0400
Date: Thu, 26 Sep 2002 14:16:53 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Joachim Breuer <jmbreuer@gmx.net>
Cc: Adam Goldstein <Whitewlf@Whitewlf.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Very High Load, kernel 2.4.18, apache/mysql
In-Reply-To: <m3adm465l6.fsf@venus.fo.et.local>
Message-ID: <Pine.LNX.4.44L.0209261415570.1837-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Joachim Breuer wrote:

> In the olden days (at least I learnt that definition for a system
> based on 3.x BSD), the "load average" is the number of runnable
> processes (i.e. those that could do work if they got a slice of CPU
> time) averaged over some period of time (1, 2, 5, 10 minutes).

> I don't know the concise definition in Linux's case either.

Extending your definition, the load average in Linux would be:

"the number of processes that could do work if they got a slice
 of CPU time or had their data in RAM instead of being blocked
 on disk"

Rik
-- 
A: No.
Q: Should I include quotations after my reply?

http://www.surriel.com/		http://distro.conectiva.com/

