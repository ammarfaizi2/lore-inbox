Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270748AbRHNTBN>; Tue, 14 Aug 2001 15:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270746AbRHNTBE>; Tue, 14 Aug 2001 15:01:04 -0400
Received: from fatbird.isisweb.nl ([212.204.202.107]:61711 "HELO
	fatbird.isisweb.nl") by vger.kernel.org with SMTP
	id <S270745AbRHNTAx>; Tue, 14 Aug 2001 15:00:53 -0400
Date: Tue, 14 Aug 2001 17:18:39 +0200 (CEST)
From: Ime Smits <ime@isisweb.nl>
To: <benjilr@free.fr>
Cc: <linux-kernel@vger.kernel.org>, Ime Smits <ime@iaehv.iae.nl>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Camino 2 (82815/82820) v2.4.x eth/sound related lockups
In-Reply-To: <997796871.3b792c0759fec@imp.free.fr>
Message-ID: <Pine.LNX.4.33.0108141714580.8479-100000@fatbird.isisweb.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

INDIVIDVVS VOCATVR benjilr@free.fr DIE 14/8/2001 15:47 VERE SCRIPSIT:

| I've had the same problem, with my intel etherExpres Pro/100
| But I've solve it, by using the e100 driver provide by intel in replacement of
| the eepro100 driver provide by kernel.
|
| You can find source of e100 at this URL : http://appsr.intel.com/scripts-
| df/File_Filter.asp?FileName=e100  I 've used the file e100-1.6.13.tar.gz.
| Compile and Install without any problem, and now, the card work perfectly.

Hey, thanks! Sound is working straight for over an hour now while some 3 GB
of traffic went over the 10BaseT! Still wondering what the problemen with
the Linux e100 driver is, though.

Ime

