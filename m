Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135549AbREITZt>; Wed, 9 May 2001 15:25:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135296AbREITZj>; Wed, 9 May 2001 15:25:39 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:9742 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S135498AbREITZc>; Wed, 9 May 2001 15:25:32 -0400
From: dth@trinity.hoho.nl (Danny ter Haar)
Subject: Re: 2.4.4-ac[356]: network (8139too) related crashes
Date: Wed, 9 May 2001 19:25:38 +0000 (UTC)
Organization: Holland Hosting
Message-ID: <9dc5ji$qj0$1@voyager.cistron.net>
In-Reply-To: <200105091321.f49DLbp06900@hal.astr.lu.lv>
X-Trace: voyager.cistron.net 989436338 27232 195.64.82.84 (9 May 2001 19:25:38 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andris Pavenis  <pavenis@latnet.lv> wrote:
>With kernels 2.4.4-ac[356] I'm getting system freezing on FTP transfer after 
>some time. I'm trying to upload about 6.5Mb file using MC (transfer speed
> about 300-1000Kb/s). With these kernel versions I'm getting random total 
>freezing system (no any kernel error messages, no reaction to keyboard,
> no response to ping from other machine). The same seems to happen also 
>when transfer speed is slower (I left wget downloading many files 2 nights
> and both times system was hanged in morning)

I have similar problems on my sony vaio laptop (pcmcia ethernet
card that works with the 8139too driver)
I send detailed info to Jeff & Alan weeks ago.

>Kernel 2.4.3-ac3 seems to be Ok.

Problems started with the change in 2.4.3-ac7.
So up to 2.4.3-ac6 it's fine.

>PS. I'm not subscribed to kernel mailing list
If you post it here, read it here!


Danny

-- 
Holland Hosting
www.hoho.nl      info@hoho.nl

