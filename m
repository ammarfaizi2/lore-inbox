Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSD3Xlv>; Tue, 30 Apr 2002 19:41:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315268AbSD3Xlu>; Tue, 30 Apr 2002 19:41:50 -0400
Received: from hera.cwi.nl ([192.16.191.8]:51913 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S315267AbSD3Xlt>;
	Tue, 30 Apr 2002 19:41:49 -0400
From: Andries.Brouwer@cwi.nl
Date: Wed, 1 May 2002 01:41:41 +0200 (MEST)
Message-Id: <UTC200204302341.g3UNffd25525.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: [WIP] Apacer SmartMedia driver
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got myself an Apacer SM/CF combo reader, USB 07c4:a109.
The CF part is supported in the stock kernel (by datafab.c),
the SM part is not.
This evening I wrote a read-only driver; hope to add the
writing part soon.
If anyone has information (or a Linux driver) I'd like to hear.

Andries


[Another interesting point is Olympus. Do I understand
correctly that Olympus put its name in the CIS, that moreover
many SM readers refuse to write the CIS, and that an Olympus
camera will say "Card Error" when it doesn't find the string
"OLYMPUS", so that Olympus can sell SM cards at a higher price?]

