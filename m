Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262506AbSJKP2O>; Fri, 11 Oct 2002 11:28:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262512AbSJKP2O>; Fri, 11 Oct 2002 11:28:14 -0400
Received: from gzp11.gzp.hu ([212.40.96.53]:59143 "EHLO gzp11.gzp.hu")
	by vger.kernel.org with ESMTP id <S262506AbSJKP2O>;
	Fri, 11 Oct 2002 11:28:14 -0400
To: linux-kernel@vger.kernel.org
From: "Gabor Z. Papp" <gzp@myhost.mynet>
Subject: Re: IDE PDC20268 in Linux 2.4.20-pre10
References: <4cc4.3da69003.2d455@gzp1.gzp.hu> <20021011141646.DC3601196B@a.mx.spoiled.org>
Organization: Who, me?
User-Agent: tin/1.5.15-20021008 ("Soil") (UNIX) (Linux/2.4.20-pre10 (i686))
Message-ID: <392d.3da6ef65.7fd5a@gzp1.gzp.hu>
Date: Fri, 11 Oct 2002 15:33:57 -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Juri Haberland <juri@koschikode.com>:

|> hde: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(33)
|> hdg: 120103200 sectors (61493 MB) w/1863KiB Cache, CHS=119150/16/63, UDMA(33)

| hde: 160086528 sectors (81964 MB) w/2048KiB Cache, CHS=9964/255/63, UDMA(100)
| hdg: 240121728 sectors (122942 MB) w/2048KiB Cache, CHS=14946/255/63, UDMA(100)
| 
| So there *is* UDMA 100 support...

Yes, there was, but disabled during 2.4.20-pre. But why?

