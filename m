Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271563AbRHPMSr>; Thu, 16 Aug 2001 08:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271564AbRHPMSh>; Thu, 16 Aug 2001 08:18:37 -0400
Received: from [210.212.250.163] ([210.212.250.163]:13324 "EHLO
	yali.rect.ernet.in") by vger.kernel.org with ESMTP
	id <S271563AbRHPMSY>; Thu, 16 Aug 2001 08:18:24 -0400
From: "Saravana" <EC19936@rect.ernet.in>
Organization: R.E.C., Tiruchirappalli, INDIA
To: linux-kernel@vger.kernel.org
Date: Thu, 16 Aug 2001 16:01:08 IST+530
Subject: Re: 
X-mailer: Pegasus Mail v3.40
Message-ID: <10D58CC5035@rect.ernet.in>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> hi!
>    I am beginning learn to write a driver follow the
> Book "Beginnng Linux programming(Second
> Edition)".There is a example about char driver,I write
> as that,but I can open device,but can't read from it.I
> just copy some static data to user buffer as follow:
>    copy_to_user(buf, schar_buffer, count)

just check out if u got any perms(rw) on the device.. ?
sarvana
