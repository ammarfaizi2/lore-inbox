Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315267AbSE2Nuj>; Wed, 29 May 2002 09:50:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315275AbSE2Nui>; Wed, 29 May 2002 09:50:38 -0400
Received: from spook.vger.org ([213.204.128.210]:33265 "HELO
	kenny.worldonline.se") by vger.kernel.org with SMTP
	id <S315267AbSE2Nuh>; Wed, 29 May 2002 09:50:37 -0400
Date: Wed, 29 May 2002 16:27:55 +0200 (CEST)
From: me@vger.org
To: Andre Hedrick <andre@linux-ide.org>,
        Thunder from the hill <thunder@ngforever.de>,
        Simen Timian Thoresen <simentt@dolphinics.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/hd[ijkl] only using udma (not udma 100)
In-Reply-To: <Pine.LNX.4.10.10205290435520.8598-100000@master.linux-ide.org>
Message-ID: <Pine.LNX.4.21.0205291625480.6798-100000@kenny.worldonline.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Upgraded to 2.4.19-pre9 and now everything work with the Promise ATA100
TX2 card when setting idex=ata66 on boot up... no need to run hdparm =)

Thanks all for the help.




