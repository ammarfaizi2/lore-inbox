Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263956AbRFEJtm>; Tue, 5 Jun 2001 05:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263951AbRFEJtc>; Tue, 5 Jun 2001 05:49:32 -0400
Received: from springer254.asv.de ([194.64.254.254]:4101 "EHLO
	springer254.asv.de") by vger.kernel.org with ESMTP
	id <S263956AbRFEJtV>; Tue, 5 Jun 2001 05:49:21 -0400
Message-ID: <016d01c0eda4$61859de0$7400a8c0@dukat.cb.de>
From: "Ingo T. Storm" <it@lapavoni.de>
To: "Tom Vier" <tmv5@home.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.2 <-> 2.4.5-ac5 tcp too slow
Date: Tue, 5 Jun 2001 11:46:22 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 4.72.3612.1700
X-MimeOLE: Produced By Microsoft MimeOLE V4.72.3612.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>reference in the list archives. i have an x86 laptop running 2.2.17
(2.2.19
>has the same effect) and an alpha pws 500 running 2.4.5-ac5. tcp
starts slow
>and get slower.

Same here. I've set up an Alpha Ruffian with a Quad Starfire as a new
firewall. My test clients were x86/2.2.16-18 up to now. TBench between
two clients directly: 10 MB/S. TBench through the 2.4.4/5 router: 0,4
MB/s.

Right now I am compiling 2.4.5 on the clients to verify that it's an
2.2 vs 2.4 issue.

Ingo


