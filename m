Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274048AbRISNOX>; Wed, 19 Sep 2001 09:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274050AbRISNON>; Wed, 19 Sep 2001 09:14:13 -0400
Received: from viper.haque.net ([66.88.179.82]:1195 "EHLO mail.haque.net")
	by vger.kernel.org with ESMTP id <S274049AbRISNNz>;
	Wed, 19 Sep 2001 09:13:55 -0400
Date: Wed, 19 Sep 2001 09:14:19 -0400 (EDT)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.10p12 net/netsyms.c -- unresolved symbol tty_register_ldisc
Message-ID: <Pine.LNX.4.33.0109190912060.32717-200000@viper.haque.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1480741555-198415517-1000905259=:32717"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.
  Send mail to mime@docserver.cac.washington.edu for more info.

--1480741555-198415517-1000905259=:32717
Content-Type: TEXT/PLAIN; charset=US-ASCII

One liner fix for unresolved symbol in PPP


--

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

--1480741555-198415517-1000905259=:32717
Content-Type: TEXT/PLAIN; charset=US-ASCII; name="netsyms.diff"
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.33.0109190914190.32717@viper.haque.net>
Content-Description: 
Content-Disposition: attachment; filename="netsyms.diff"

LS0tIG5ldC9uZXRzeW1zLmMub3JpZwlXZWQgU2VwIDE5IDAyOjMyOjQyIDIw
MDENCisrKyBuZXQvbmV0c3ltcy5jCVdlZCBTZXAgMTkgMDk6MTA6MzEgMjAw
MQ0KQEAgLTUwNCw2ICs1MDQsNyBAQA0KIEVYUE9SVF9TWU1CT0woZGV2X21j
X2FkZCk7DQogRVhQT1JUX1NZTUJPTChkZXZfbWNfZGVsZXRlKTsNCiBFWFBP
UlRfU1lNQk9MKGRldl9tY191cGxvYWQpOw0KK0VYUE9SVF9TWU1CT0wodHR5
X3JlZ2lzdGVyX2xkaXNjKTsNCiBFWFBPUlRfU1lNQk9MKF9fa2lsbF9mYXN5
bmMpOw0KIA0KIEVYUE9SVF9TWU1CT0woaWZfcG9ydF90ZXh0KTsNCg==
--1480741555-198415517-1000905259=:32717--
