Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSI2X5B>; Sun, 29 Sep 2002 19:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbSI2X5A>; Sun, 29 Sep 2002 19:57:00 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21465 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261848AbSI2X4W>;
	Sun, 29 Sep 2002 19:56:22 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 30 Sep 2002 02:01:44 +0200 (MEST)
Message-Id: <UTC200209300001.g8U01iY27223.aeb@smtp.cwi.nl>
To: Andries.Brouwer@cwi.nl, acme@conectiva.com.br
Subject: Re: [PATCH] net/Config.in
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, accepted, I'm pushing to DaveM in some moments ...

OK, that was the configuration part.
The kernel oopses at boot time in llc_sap_find().
I seem to recall that I saw some such oopses on lk
but didnt pay attention. Has this been fixed already?

Andries
