Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273976AbRIXQIJ>; Mon, 24 Sep 2001 12:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273978AbRIXQH5>; Mon, 24 Sep 2001 12:07:57 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:64517 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S273976AbRIXQHi>; Mon, 24 Sep 2001 12:07:38 -0400
Message-Id: <200109241608.f8OG80Y89488@aslan.scsiguy.com>
To: Olaf Zaplinski <o.zaplinski@mediascape.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: AIC7xxx errors (again) with 2.4.10pre15 
In-Reply-To: Your message of "Mon, 24 Sep 2001 17:39:12 +0200."
             <3BAF53A0.8D82A87B@mediascape.de> 
Date: Mon, 24 Sep 2001 10:08:00 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Hi all,
>
>my software RAID1 (hda1+sda1) worked fine with the current aic7xxx driver
>when using 2.4.10pre13, but with 2.4.10pre15 I get the old behaviour I know
>from 2.4.9:

What is your hardware configuration?  A full dmesg with aic7xxx=verbose
should be sufficient.

--
Justin
