Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317399AbSFHLYY>; Sat, 8 Jun 2002 07:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317404AbSFHLYX>; Sat, 8 Jun 2002 07:24:23 -0400
Received: from pD9E2320A.dip.t-dialin.net ([217.226.50.10]:38356 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317399AbSFHLYW>; Sat, 8 Jun 2002 07:24:22 -0400
Date: Sat, 8 Jun 2002 05:23:16 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Michael De Nil <linux@aerythmic.be>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: /dev/input/mice problem with 2.4.19-pre9 & 10
In-Reply-To: <Pine.LNX.4.44.0206081137310.32319-100000@LiSa>
Message-ID: <Pine.LNX.4.44.0206080522040.15675-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 8 Jun 2002, Michael De Nil wrote:
> When I move my mouse while catting /dev/input/mice, nothing appears ...
> 
> Other USB-device work...

Please try /dev/input/mouse0.

[thunder@hawkeye.luckynet.adm /usr/src/thunder-2.5.20] (0) ls -l /dev/input/
total 0
crw-r--r--    1 root     root      13,  63 Dec 31  1969 mice
crw-r--r--    1 root     root      13,  32 Dec 31  1969 mouse0
[thunder@hawkeye.luckynet.adm /usr/src/thunder-2.5.20] (0)

Regards,
Thunder
-- 
ship is leaving right on time	|	Thunder from the hill at ngforever
empty harbour, wave goodbye	|
evacuation of the isle		|	free inhabitant not directly
caveman's paintings drowning	|	belonging anywhere

