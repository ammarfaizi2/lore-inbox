Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132765AbRBRNr2>; Sun, 18 Feb 2001 08:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132858AbRBRNrS>; Sun, 18 Feb 2001 08:47:18 -0500
Received: from slamp.tomt.net ([195.139.204.145]:51416 "HELO slamp.tomt.net")
	by vger.kernel.org with SMTP id <S132765AbRBRNrF>;
	Sun, 18 Feb 2001 08:47:05 -0500
From: "Andre Tomt" <andre@tomt.net>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Cc: "Mordechai Ovits" <movits@ovits.net>
Subject: RE: 2.4.1 crashing every other day
Date: Sun, 18 Feb 2001 14:47:12 +0100
Message-ID: <OPECLOJPBIHLFIBNOMGBIEHEDBAA.andre@tomt.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <20010218003125.A25564@ovits.net>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Looks like you were bitten by either the RAID 1 bugs or the elevator bugs.
> Try a 2.4.2-pre4 or an 2.4.1-ac18 kernel.  Should solve it.

Just installed 2.4.2pre4, seems to be stable for now (testing it ATM,
running dnetc, several kernel compiles etc.). On 2.4.1 even su segfault'd if
the server were loaded. But, the problems have never appeared before after
one or two days uptime, so we'll just have to see what happens later on.

As the BIOS settings are the same on both servers, and the CPU temperature
peaked at +43.5C on the crashing server, I might just think it's a software
bug. Well, time will tell :-)

Thanks for the input

--
Regards,
Andre Tomt

