Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272383AbRIFBnq>; Wed, 5 Sep 2001 21:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272375AbRIFBng>; Wed, 5 Sep 2001 21:43:36 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:15120 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S272383AbRIFBn1>; Wed, 5 Sep 2001 21:43:27 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109060149.SAA13180@boojiboy.eorbit.net>
Subject: Re: Solo sound - 2.4.10-pre build fails
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Sep 2001 18:49:40 -0700 (PDT)
Cc: alan@lxorguk.ukuu.org.uk
In-Reply-To: <200109051900.MAA04249@boojiboy.eorbit.net> from "chris@boojiboy.eorbit.net" at Sep 05, 2001 12:00:51 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a laptop with an ESS solo sound chip.
> I tried compiling 2.4.10-pre4 and
> the build fails on the sound code.


The linux kernel 2.4.9-ac9 does build while
using the esssolo.c code.  

Somehow this code is broken in 2.4.10-pre

--Chris
