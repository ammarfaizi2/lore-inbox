Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285114AbRLFLVE>; Thu, 6 Dec 2001 06:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285115AbRLFLUy>; Thu, 6 Dec 2001 06:20:54 -0500
Received: from mail.terraempresas.com.br ([200.177.96.20]:18439 "EHLO
	mail.terraempresas.com.br") by vger.kernel.org with ESMTP
	id <S285114AbRLFLUg>; Thu, 6 Dec 2001 06:20:36 -0500
Message-ID: <002d01c17e48$6df98a20$1300a8c0@marcelo>
From: "Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>
To: <linux-kernel@vger.kernel.org>
Subject: making an ide hd sleep
Date: Thu, 6 Dec 2001 09:23:28 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I´d like to know if it's possible to put an ide hd to sleep after (for
example) 15 min. idle (i don´t know if an hd under linux stays  idle that
amount of time. ). I tried mount -o noatime and hdparm -S 150 /dev/hda, but
it seems that when it sleeps it starts working after a few seconds (when it
sleeps!). Is there a way to have this feature under linux?


Thanks in advance,
Marcelo Ribeiro

