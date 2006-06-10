Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030396AbWFJP1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbWFJP1W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 11:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWFJP1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 11:27:22 -0400
Received: from moutng.kundenserver.de ([212.227.126.177]:4324 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030396AbWFJP1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 11:27:21 -0400
Date: Sat, 10 Jun 2006 17:25:23 +0200 (CEST)
From: prx <root@cinatas.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.17-rc6-mm1] Oops during sata_promise init
Message-ID: <Pine.LNX.4.61.0606101715440.3135@cinatas.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:80ab310fced15248f8e2da3e2d36cb52
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry for my late answer.

The hardware which Oopses due to the third (PATA) channel is:
02:0b.0 Mass storage controller: Promise Technology, Inc.
PDC20575 (SATAII150 TX2plus) (rev 02)

I know it's the PATA chan which fails because i commented the
part discovering the third channel out, giving me a working
system :)

Thanks for that suggestion / idea :)

kind regards

prx
