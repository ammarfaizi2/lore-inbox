Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270203AbRHROvz>; Sat, 18 Aug 2001 10:51:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270204AbRHROvq>; Sat, 18 Aug 2001 10:51:46 -0400
Received: from mail.fbab.net ([212.75.83.8]:36625 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S270203AbRHROve>;
	Sat, 18 Aug 2001 10:51:34 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: riel@conectiva.com.br linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 8.153163 secs)
Message-ID: <015d01c127f5$93ec9230$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: "Rik van Riel" <riel@conectiva.com.br>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0108171818040.2277-100000@duckman.distro.conectiva>
Subject: Re: 2.4.8 Resource leaks + limits
Date: Sat, 18 Aug 2001 16:53:44 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Rik van Riel" <riel@conectiva.com.br>
[snip]
> 
> Morale of the story:  whenever you find a bug, try if you
> can reproduce it with Alan's kernel ;)
> 

Ok, i got it.
I tried with 2.4.8ac5 and it seems to hold nicely.
Too bad this isn't so much documented.
The whole pam_limit thing is pretty poorly detailed.
Like the prio limit, it doesn't say what ranges and so on.
(well it's the same as nice, but it doesnt say that eihter i think :))

> Rik
> 

Magnus

-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
 Programmer/Networker [|] Magnus Naeslund
 PGP Key: http://www.genline.nu/mag_pgp.txt
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-


