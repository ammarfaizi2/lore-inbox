Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273535AbRIQIf2>; Mon, 17 Sep 2001 04:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273536AbRIQIfS>; Mon, 17 Sep 2001 04:35:18 -0400
Received: from AMontpellier-201-1-1-55.abo.wanadoo.fr ([193.252.31.55]:20228
	"EHLO awak") by vger.kernel.org with ESMTP id <S273535AbRIQIfK> convert rfc822-to-8bit;
	Mon, 17 Sep 2001 04:35:10 -0400
Subject: Re: 2.4.9: multiply mounting filesystem
From: Xavier Bestel <xavier.bestel@free.fr>
To: Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3BA5BE90.29409.43AC7B@localhost>
In-Reply-To: <3BA5BE90.29409.43AC7B@localhost>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99+cvs.2001.09.14.21.31 (Preview Release)
Date: 17 Sep 2001 10:30:29 +0200
Message-Id: <1000715429.4422.14.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

le lun 17-09-2001 at 09:12 Ulrich Windl a écrit :
> Hi,
> 
> yesterday I mounted a filesystem /dev/sda9 (resierfs) twice (first time 
> as /, second time as /mnt) by mistake. Neither kernel nor mount program 
> complained. I'm very much afraid this could corrupt the filesystem. Or 
> is Linux really smart enough to handle the case?  

It's indeed a new feature of 2.4 kernels.

          Xav

