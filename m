Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287379AbRL3Kw2>; Sun, 30 Dec 2001 05:52:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287380AbRL3KwS>; Sun, 30 Dec 2001 05:52:18 -0500
Received: from p15.dynadsl.ifb.co.uk ([194.105.168.15]:2188 "HELO smeg")
	by vger.kernel.org with SMTP id <S287379AbRL3KwB>;
	Sun, 30 Dec 2001 05:52:01 -0500
From: "Lee Packham" <lpackham@mswinxp.net>
To: <linux-kernel@vger.kernel.org>
Subject: [BUG] 2.5.1-dj8 - IDE CD-ROM
Date: Sun, 30 Dec 2001 10:51:22 -0000
Message-ID: <000101c1911f$eba8b380$010ba8c0@lee>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On a VIA KT266a chipset motherboard with a standard IDE CD-ROM device I
get input/output errors on all iso9660 + joilet CD's. I don't have any
basic CDs to try.

On 2.4.10-2.4.16 it works fine. Am just about to test on 2.4.17 but
thought I would post this now. I am using the same .config from 2.4.10
in 2.5.1-dj8 if that helps.

Lee Packham

