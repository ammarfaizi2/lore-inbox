Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262621AbSJ0Uwj>; Sun, 27 Oct 2002 15:52:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262625AbSJ0Uwj>; Sun, 27 Oct 2002 15:52:39 -0500
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:51151 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP
	id <S262621AbSJ0Uwj>; Sun, 27 Oct 2002 15:52:39 -0500
From: "Buddy Lumpkin" <b.lumpkin@attbi.com>
To: "'Albert D. Cahalan'" <acahalan@cs.uml.edu>,
       <linux-kernel@vger.kernel.org>
Subject: RE: vmstat
Date: Sun, 27 Oct 2002 13:02:24 -0800
Message-ID: <001d01c27dfc$267afc60$0472e50c@peecee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
In-Reply-To: <200210240542.g9O5gsh357557@saturn.cs.uml.edu>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Also, am I right about 2.2.xx kernels? Are any of these
>kernels affected by block size of a mounted filesystem?
>Does it matter if I use a /dev/raw* device? Does any
>kernel use different units for file bodies and metadata?

Raw devices are character special devices allowing arbitrary sized reads
and writes of 1 byte or more.

--Buddy


