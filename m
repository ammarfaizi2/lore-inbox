Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266698AbUBET5T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 14:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266711AbUBET5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 14:57:19 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:24013 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S266698AbUBET5R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 14:57:17 -0500
Message-ID: <000501c3ec22$46444bb0$0e25fe96@pysiak>
From: "Maciej Soltysiak" <solt@dns.toxicfilms.tv>
To: <linux-kernel@vger.kernel.org>
References: <20040205014405.5a2cf529.akpm@osdl.org> <200402051357.04005.s0348365@sms.ed.ac.uk> <4022505B.1020900@vision.ee>
Subject: Re: 2.6.2-mm1 [are these mine?]
Date: Thu, 5 Feb 2004 20:57:17 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Spam-Rating: 0 1.6.2 0/1000/N
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.2-mm1 contains:
 sound/oss/dmasound/tas3001c.c                                       1 +
1 -       0 !
 sound/oss/dmasound/tas3001c_tables.c                              166 +
166 -       0 !
 sound/oss/dmasound/tas3004_tables.c                               120 +
120 -       0 !
 sound/oss/dmasound/trans_16.c                                      22 +
22 -       0 !
 sound/oss/sb_card.h                                                50 +
50 -       0 !

I would like to ask if these are from the batch I proposed a while ago
during 2.6.0 available at:
http://soltysiak.com/patches/2.6/2.6.0/c99/patch-2.6.0-c99.diff
split:
http://soltysiak.com/patches/2.6/2.6.0/c99/split/

It would add to my other C99 contributed patches list :-)

Regards,
Maciej

