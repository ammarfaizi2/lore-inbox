Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274397AbRITKHq>; Thu, 20 Sep 2001 06:07:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274400AbRITKHg>; Thu, 20 Sep 2001 06:07:36 -0400
Received: from mail.fbab.net ([212.75.83.8]:21769 "HELO mail.fbab.net")
	by vger.kernel.org with SMTP id <S274397AbRITKH0>;
	Thu, 20 Sep 2001 06:07:26 -0400
X-Qmail-Scanner-Mail-From: mag@fbab.net via mail.fbab.net
X-Qmail-Scanner-Rcpt-To: mmokrejs@natur.cuni.cz linux-kernel@vger.kernel.org
X-Qmail-Scanner: 0.94 (No viruses found. Processed in 6.372139 secs)
Message-ID: <05ab01c141bc$6c5a9f60$020a0a0a@totalmef>
From: "Magnus Naeslund\(f\)" <mag@fbab.net>
To: =?iso-8859-1?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.OSF.4.21.0109201149110.3983-100000@prfdec.natur.cuni.cz>
Subject: Re: Cannot compile 2.4.10pre12aa1 with 2.95.2 on Debian
Date: Thu, 20 Sep 2001 12:10:06 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Martin MOKREJ©" <mmokrejs@natur.cuni.cz>

There are two defines for that FPU thing around line 421 in sched.c, take
one away (i deleted the 1<<6 one).

I'm running that kernel now.

Magnus


