Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313332AbSC2BVD>; Thu, 28 Mar 2002 20:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313333AbSC2BUy>; Thu, 28 Mar 2002 20:20:54 -0500
Received: from 136.139.hh1.ip.foni.net ([212.7.139.136]:9732 "HELO
	debian.heim.lan") by vger.kernel.org with SMTP id <S313331AbSC2BUo>;
	Thu, 28 Mar 2002 20:20:44 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Christian Schoenebeck <christian.schoenebeck@epost.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: power off
Date: Fri, 29 Mar 2002 01:59:05 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <E16qiP6-00006d-00@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020329003505.8E3BC47B1@debian.heim.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Es geschah am Donnerstag, 28. März 2002 23:29 als Alan Cox schrieb:
> Try both 16 and 32bit power off options when building the kernel - and make
> sure you have apm enabled. It may well be only one of the two works on
> your box

What do you mean with 16/32 bit option - couldn't find anything about that or 
do you mean realmode_power_off? If yes, I already tried that (and of your 
course I also enabled apm).
