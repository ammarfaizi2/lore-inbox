Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132666AbRDBKZ0>; Mon, 2 Apr 2001 06:25:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132668AbRDBKZR>; Mon, 2 Apr 2001 06:25:17 -0400
Received: from epsongw2.epson.co.jp ([210.254.46.180]:55734 "EHLO
	epsongw2.epson.co.jp") by vger.kernel.org with ESMTP
	id <S132667AbRDBKZG>; Mon, 2 Apr 2001 06:25:06 -0400
Date: Mon, 2 Apr 2001 19:23:04 +0900
From: Aric Cyr <acyr@mail.com>
To: linux-kernel@vger.kernel.org
Cc: gregvb@theblackfire.net
Subject: Re: PROBLEM:Bug when installing NVidia Driver Module
Message-ID: <20010402192304.E4754@esd.spr.epson.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
User-Agent: Mutt/1.2.5i-jp0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to the kernel soruces, _mmx_memcpy is only defined when
Athlon is selected...

I noticed that you are using GCC 2.96... Is this the latest one that
Redhat recommends you update in order to build the kernel?  I forget,
something like GCC 2.96-79.

I have a similar setup at home... I'll try the new nVidia drivers
tonight and see how it goes.

- Aric
