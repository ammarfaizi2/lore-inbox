Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265037AbTBTJY4>; Thu, 20 Feb 2003 04:24:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265039AbTBTJY4>; Thu, 20 Feb 2003 04:24:56 -0500
Received: from 251.017.dsl.syd.iprimus.net.au ([210.50.55.251]:27015 "EHLO
	file1.syd.nuix.com.au") by vger.kernel.org with ESMTP
	id <S265037AbTBTJYy> convert rfc822-to-8bit; Thu, 20 Feb 2003 04:24:54 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Song Zhao <song.zhao@nuix.com.au>
Reply-To: song.zhao@nuix.com.au
Organization: Nuix
To: linux-kernel@vger.kernel.org
Subject: Supermicro X5DL8-GG (ServerWorks Grandchampion LE chipset) slow
Date: Thu, 20 Feb 2003 20:34:28 -0500
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200302202034.28676.song.zhao@nuix.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I've been doing some benchmarks with this board, it is terribly disppointing. 
Has anyone had similar experiences?

The hardware spec is:
Dual 2.8GHz Xeon, 3ware Escalade 7850 (7500-8) 12 port IDE RAID controller, 
RAID 10, 4x 1GB DDR SDRAM Registered ECC, 2x 80GB WD HDD, 10x 120GB WD HDD, 
ServerWorks Grand Champion LE. 

I am running RH7.3 with 2.4.20 kernel. The performance of this box is about 
half of an almost identical box (Supermicro X5DP8-G2 mobo, E7501 chipset)

Also, this board can't even boot with 8x 1GB memory modules plugged in (8 DIMM 
slots in total). This is a relative new board and I can't find anything 
relevant on the net. 

cheers,
Song Zhao
