Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265754AbTAJS2Y>; Fri, 10 Jan 2003 13:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265819AbTAJS0d>; Fri, 10 Jan 2003 13:26:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59265 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265713AbTAJSZl>; Fri, 10 Jan 2003 13:25:41 -0500
Date: Fri, 10 Jan 2003 13:36:46 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Hell.Surfers@cwctv.net
cc: vlad@geekizoid.com, jalvo@mbay.net, linux-kernel@vger.kernel.org,
       rms@gnu.org
Subject: RE: What's in a name?
In-Reply-To: <0b9ad5923170a13DTVMAIL1@smtp.cwctv.net>
Message-ID: <Pine.LNX.3.95.1030110132230.27408A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2003 Hell.Surfers@cwctv.net wrote:

> what early distribution? grep gpl and lgpl...
> 
> -- DM.
> 

Yggdrasl (or however you spell it). Most binary files have
the date of Feb 26, 1996. Many text files have the date of
July 11, 1995. I have sources, many with the dates of
Aug 31, 1992:

-rw-r--r--   1 root     bin          4502 Aug 31  1992 CHANGES
-rw-r--r--   1 root     bin          1658 Aug 31  1992 README
-rw-r--r--   1 root     bin          2029 Aug 31  1992 brac.c
-rw-r--r--   1 root     bin         11258 Aug 31  1992 ch.c
-rw-r--r--   1 root     bin          3534 Aug 31  1992 charset.c
[SNIPPED...]

In those days very few persons even heard of GPL.

These are the only gpl or GPL strings found in any binaries.

sub showGPL {
last if (/^{END OF GPL COPYRIGHT}$/) ;
last if (/^{END OF GPL CONDITIONS}$/) ;
    &showGPL unless $QUIET ;
{END OF GPL COPYRIGHT}
{END OF GPL CONDITIONS}
   To appear in SIGPLAN Conference on Programming Language Design 
  label .about.gpl3 -text "Pulic License (GPL)"


Note that "Public" is even spelled incorrectly!


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


