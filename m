Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261321AbSK1P1S>; Thu, 28 Nov 2002 10:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbSK1P1R>; Thu, 28 Nov 2002 10:27:17 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:56334 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S261321AbSK1P1R>; Thu, 28 Nov 2002 10:27:17 -0500
Message-ID: <3DE63792.180BAECF@compuserve.com>
Date: Thu, 28 Nov 2002 10:34:42 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>, Samium Gromoff <_deepfire@mail.ru>
Subject: Re: DAC960 at 2.5.50
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Samium Gromoff...
> > <alan@lxorguk.ukuu.org.uk>
> >         [PATCH] update to OSDL DAC960 driver
> >
> >         Its not perfect but it works
>    is it supposed to blow my data, or is it relatively safe to use?

There have been a few poeple using this patch for about 5 versions of
2.5 so far.  I haven't done heavy testing myself, just booting and doing
some other testing of modules and drivers.  I am running the DAC960 on
my root/boot filesystem and haven't seen any problems yet.

-- 
Kevin
