Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262035AbSJEEvj>; Sat, 5 Oct 2002 00:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262036AbSJEEvi>; Sat, 5 Oct 2002 00:51:38 -0400
Received: from mta03ps.bigpond.com ([144.135.25.135]:26310 "EHLO
	mta03ps.bigpond.com") by vger.kernel.org with ESMTP
	id <S262035AbSJEEvi>; Sat, 5 Oct 2002 00:51:38 -0400
Message-ID: <07ea01c26c2b$7e1e6570$41368490@archaic>
From: "David McIlwraith" <quack@bigpond.net.au>
To: "Carlos E Gorges" <carlos@techlinux.com.br>
Cc: <linux-kernel@vger.kernel.org>
References: <200210021902.35813.carlos@techlinux.com.br>
Subject: Re: [PATCH] 2.5.40 - random fixes
Date: Sat, 5 Oct 2002 14:55:56 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.3663.0
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3663.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]

The DAC960 driver is still broken, due to the deprecation of major parts of
the genhd code, including register_disk().

- David McIlwraith

