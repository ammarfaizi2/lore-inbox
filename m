Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130920AbRCFEdQ>; Mon, 5 Mar 2001 23:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130922AbRCFEdF>; Mon, 5 Mar 2001 23:33:05 -0500
Received: from smtp.bellnexxia.net ([209.226.175.26]:17642 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130920AbRCFEcq>; Mon, 5 Mar 2001 23:32:46 -0500
Message-ID: <005101c0a5f6$798a0480$9666a8c0@centerlight.net>
From: "Nicolas Cadou" <niccad@virtuel.qc.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Console driver and printing
Date: Mon, 5 Mar 2001 23:32:37 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I would like to know if know if there is any support for printing in the
console driver. I mean, can the console receive from an application an
mc4/mc5 sequence as defined in a terminfo entry and print what was sent in
between? If so is there any way to configure the device to which the data
would be sent?

I hope I do not abuse this list by posting this question here, but I
couldn't find any information anywhere else.

If I can't print through the console, would anybody have any experience
about configuring an xterm (which can print, I tested it) to use a cp437
(IBM) encoding?

I've always managed to find everything myself, but I'm running short on time
and this is the last problem before installing linux in 50 to 100 stores, so
I could use a little help :-)

Nicolas Cadou

