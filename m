Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262523AbSI0Qew>; Fri, 27 Sep 2002 12:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262532AbSI0Qew>; Fri, 27 Sep 2002 12:34:52 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:53955 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S262523AbSI0Qev>;
	Fri, 27 Sep 2002 12:34:51 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200209271639.UAA21514@sex.inr.ac.ru>
Subject: Re: [PATCH] IPv6: Refine IPv6 Address Validation Timer
To: yoshfuji@linux-ipv6.org (YOSHIFUJI Hideaki /
	=?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=)
Date: Fri, 27 Sep 2002 20:39:45 +0400 (MSD)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       usagi@linux-ipv6.org
In-Reply-To: <20020928.011439.108856769.yoshfuji@linux-ipv6.org> from "YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?=" at Sep 28, 2 01:14:39 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> (*) Oops, I slipped at (almost) end of the patch when making patch... sorry;
> I inteded to refine timing into ~0.5 sec at worst;

Does this matter? What is special about 0.5sec comparing to 1?

> (do I need to resend complete patch?)

No, I think. Deletion of bad debugging is easier to make after patching.

Alexey
