Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUA0WpH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 17:45:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUA0WpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 17:45:07 -0500
Received: from relay1.eltel.net ([195.209.236.38]:23174 "EHLO relay1.eltel.net")
	by vger.kernel.org with ESMTP id S264450AbUA0WpC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 17:45:02 -0500
Date: Wed, 28 Jan 2004 01:45:00 +0300
From: Andrew Zabolotny <zap@homelink.ru>
To: linux-kernel@vger.kernel.org
Subject: A small fix to ac97 OSS driver
Message-Id: <20040128014500.7c2ff5e3.zap@homelink.ru>
Organization: home
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: #%`a@cSvZ:n@M%n/to$C^!{JE%'%7_0xb("Hr%7Z0LDKO7?w=m~CU#d@-.2yO<l^giDz{>9
 epB|2@pe{%4[Q3pw""FeqiT6rOc>+8|ED/6=Eh/4l3Ru>qRC]ef%ojRz;GQb=uqI<yb'yaIIzq^NlL
 rf<gnIz)JE/7:KmSsR[wN`b\l8:z%^[gNq#d1\QSuya1(
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Wed__28_Jan_2004_01_45_00_+0300__8qAnRWSWog6MfNG"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart=_Wed__28_Jan_2004_01_45_00_+0300__8qAnRWSWog6MfNG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello!

There is a small obvious bug in sound/oss/ac97_codec.c. I've found the
bug in handhelds.org' branch of kernel 2.6 which is a little behind
the mainstream kernel so please don't kill me if this has been already
fixed.

--
Greetings,
   Andrew

--Multipart=_Wed__28_Jan_2004_01_45_00_+0300__8qAnRWSWog6MfNG
Content-Type: application/x-gzip;
 name="ac97_codec.diff.gz"
Content-Disposition: attachment;
 filename="ac97_codec.diff.gz"
Content-Transfer-Encoding: base64

H4sICKvkFkAAA2FjOTdfY29kZWMuZGlmZgClUE1PwzAMPSe/wqepU5t1/dgmOnWqxAk0cQBxrqbE
hYguQUlbhtD+O2nL0IbghOUoznsvz5ZvlMBDBjt+tSq5FshnnOb/D3p//QCVrDGDkHc2rKVqD+EL
GoV1vAytbpUItbXheeOgowYbI7GT6gmMu6zUCqLZggpZVcBaYMa9LqdljF0AJE7gTncQz+cJRMss
TbMkATZ3QXor3/d/6Fdwu1O9PoU4zlwmi1FPiwJYlKarIErAH4sUioICcSn0m/Img0tpcT9dO6yW
tikF1qVUsvEmwsgODdv0sOMZof5JVGlT4o4/e3UAo4mdOu7DHcIhh0GEqjHvvcI2puXN2dwBfHsS
WXmcbcZekOcwVlPq/0nB0IacxjO41x16zvSLH2zPPsLd43a77g1/R4/O7jhupX293Mkni89EPGEC
AAA=

--Multipart=_Wed__28_Jan_2004_01_45_00_+0300__8qAnRWSWog6MfNG--
