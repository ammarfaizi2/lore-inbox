Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129359AbRCYLaG>; Sun, 25 Mar 2001 06:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130903AbRCYL34>; Sun, 25 Mar 2001 06:29:56 -0500
Received: from saarinen.org ([203.79.82.14]:51934 "EHLO vimfuego.saarinen.org")
	by vger.kernel.org with ESMTP id <S129478AbRCYL3t>;
	Sun, 25 Mar 2001 06:29:49 -0500
From: "Juha Saarinen" <juha@saarinen.org>
To: <drew@drewb.com>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.3-pre7 and System.map, bzImage ??
Date: Sun, 25 Mar 2001 23:29:10 +1200
Message-ID: <LNBBIBDBFFCDPLBLLLHFEEJCJIAA.juha@saarinen.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <15037.54052.77265.743026@champ.serialhacker.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:: I've compiled 2.4.3-pre7 and no errors were reported, yet I can't find
:: the kernel bzImage or System.map file.  Did I miss a major change in the
:: install procedure since 2.4.1?
:: 
:: I can't find any references in the docs or archives.

Do:

	make bzlilo

and look in your / directory.

-- Juha
