Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267425AbSKQBI2>; Sat, 16 Nov 2002 20:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267426AbSKQBI2>; Sat, 16 Nov 2002 20:08:28 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:53681 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267425AbSKQBI1>; Sat, 16 Nov 2002 20:08:27 -0500
Subject: Re: [RFC][PATCH 2.5-ac] Doesn't  boot when compile for i386, i486
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Osamu Tomita <tomita@cinet.co.jp>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <3DD6E10B.EF597421@cinet.co.jp>
References: <3DD6E10B.EF597421@cinet.co.jp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 17 Nov 2002 01:42:22 +0000
Message-Id: <1037497342.24843.41.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-17 at 00:21, Osamu Tomita wrote:
> 2.5.45-ac1 and 2.5.47-ac[1-5] doesn't boot when compile
>  for CPU without TSC.
> By following patch, boot and work at this time.
> Any problems? Please comment.

I've just applied some changes from James Bottomley which I hope have
cured this bug

