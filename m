Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267130AbSLDWds>; Wed, 4 Dec 2002 17:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267131AbSLDWds>; Wed, 4 Dec 2002 17:33:48 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:33265
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S267130AbSLDWdq>; Wed, 4 Dec 2002 17:33:46 -0500
Message-ID: <100401c29be5$776d8f00$6502a8c0@jeff>
From: "Jeff Nguyen" <jeff@aslab.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: <linux-kernel@vger.kernel.org>
References: <A5974D8E5F98D511BB910002A50A66470580D41F@hdsmsx103.hd.intel.com > <36490000.1038853452@aslan.btc.adaptec.com>
Subject: Re: AIC79xx driver question
Date: Wed, 4 Dec 2002 14:35:36 -0800
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

Hello Justin,

The latest aic79xx source code (v1.1.0) found on Adaptec Web site
does not compile under 2.4.20 kernel. The makefile references to
an object file, aic7xxx_reg_print.o, which does not exist at all. 

Is there a patch that I can run to fix this error?

Jeff




