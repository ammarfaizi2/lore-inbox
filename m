Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbSKTHdL>; Wed, 20 Nov 2002 02:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267650AbSKTHcV>; Wed, 20 Nov 2002 02:32:21 -0500
Received: from mtl.slowbone.net ([213.237.73.175]:3968 "EHLO
	leeloo.slowbone.net") by vger.kernel.org with ESMTP
	id <S267643AbSKTHbY>; Wed, 20 Nov 2002 02:31:24 -0500
Message-ID: <009101c29067$d470f900$0201a8c0@mtl>
From: =?iso-8859-1?Q?Thorbj=F8rn_Lind?= <mtl@slowbone.net>
To: "Andrew Morton" <akpm@digeo.com>
Cc: <linux-kernel@vger.kernel.org>
References: <3DDAE54F.4010808@slowbone.net> <3DDB353F.33D826C8@digeo.com>
Subject: Re: [patch] 2.5.48-bk, md raid0 fix
Date: Wed, 20 Nov 2002 08:38:33 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The mod operator on a 64-bit quantity won't work with
> CONFIG_LBD=y, will it?

Ohh.. there is such a thing.. let's use & :)



