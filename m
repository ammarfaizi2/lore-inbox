Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264608AbTL0V4i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 16:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbTL0V4i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 16:56:38 -0500
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:51098 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id S264608AbTL0V4g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 16:56:36 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Henrik Storner <henrik-kernel@hswn.dk>
Newsgroups: linux.kernel
Subject: Re: OSS sound emulation broken between 2.6.0-test2 and test3
Date: Sat, 27 Dec 2003 21:56:35 +0000 (UTC)
Organization: Linux Users Inc.
Message-ID: <bskv6j$aje$1@ask.hswn.dk>
References: <1072535590.12308.250.camel@nosferatu.lan> <1080000.1072475704@[10.10.2.4]>	 <1072479167.21020.59.camel@nosferatu.lan>  <1480000.1072479655@[10.10.2.4]>	 <1072480660.21020.64.camel@nosferatu.lan>  <1640000.1072481061@[10.10.2.4]>	 <1072482611.21020.71.camel@nosferatu.lan>  <2060000.1072483186@[10.10.2.4]>	 <1072500516.12203.2.camel@duergar>  <8240000.1072511437@[10.10.2.4]>	 <1072523478.12308.52.camel@nosferatu.lan>	 <1072525450.3794.8.camel@wires.home.biz>	 <1072527874.12308.100.camel@nosferatu.lan>	 <1072530488.2906.1.camel@wires.home.biz>	 <1072535590.12308.250.camel@nosferatu.lan> <1072544151.8611.18.camel@wires.home.biz>
NNTP-Posting-Host: osiris.hswn.dk
X-Trace: ask.hswn.dk 1072562195 10862 172.16.10.100 (27 Dec 2003 21:56:35 GMT)
X-Complaints-To: news@ask.hswn.dk
NNTP-Posting-Date: Sat, 27 Dec 2003 21:56:35 +0000 (UTC)
User-Agent: nn/6.6.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <1072544151.8611.18.camel@wires.home.biz> Edward Tandi <ed@efix.biz> writes:

>I would say the symptoms are that the music starts playing OK bit after
>a short period (18-19 seconds), the music changes overall speed (by a
>semi-tone or so). When it does this, the sound also starts to break up.

Just a "me too" post - I've been trying out 2.6.0 over the past couple
of days, and this is the only real issue I've encountered. Just like
you describe, the pace of the music playing speeds up slightly, and
there are some mis-sounds for a few seconds. Then it comes back to
normal.

>It could be a driver issue. FYI, I am using a VIA KT400 chipset.

Could be. I have the same chipset (KT400A, actually).

-- 
Henrik Storner
