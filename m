Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314274AbSEHNwR>; Wed, 8 May 2002 09:52:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314275AbSEHNwQ>; Wed, 8 May 2002 09:52:16 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:51981 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314274AbSEHNwQ>; Wed, 8 May 2002 09:52:16 -0400
Message-Id: <200205081341.g48DfqX23864@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] 2.5.14 IDE 56
Date: Wed, 8 May 2002 16:46:12 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0205052046590.1405-100000@home.transmeta.com> <3CD7B8FE.1020505@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 May 2002 09:22, Martin Dalecki wrote:
> Mon May  6 13:29:44 CEST 2002 ide-clean-56

+	printk("%s: reset timed-out, status=0x%02x\n", ch->name, stat);

"timed out" (no dash)
--
vda
