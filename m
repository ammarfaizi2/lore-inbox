Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283658AbRLMIM5>; Thu, 13 Dec 2001 03:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283717AbRLMIMr>; Thu, 13 Dec 2001 03:12:47 -0500
Received: from netfinity.realnet.co.sz ([196.28.7.2]:29595 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S283658AbRLMIMc>; Thu, 13 Dec 2001 03:12:32 -0500
Date: Thu, 13 Dec 2001 10:14:43 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <fridtjof@fbunet.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Repost: ASUS APM Problem (ASUS L8400L & ASUS P2B-F
Message-ID: <Pine.LNX.4.33.0112131010570.1859-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Anybody know why APM doesn't work with products from ASUS?
>Is this a known bug?

I think thats a bit of a generalisation...

>ASUS P2B-F Board, x86 based desktop system

I have an Asus P2B (i think the ATX form factor version of your P2B-F) and
APM works pretty well here, i recently had an APIC error on resume which
was finally resolved with a patch by Mikael Patterson. So i can vouch for
having a somewhat APM sane Asus board.

Cheers,
	Zwane Mwaikambo


