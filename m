Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316611AbSE0NkU>; Mon, 27 May 2002 09:40:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316616AbSE0NkT>; Mon, 27 May 2002 09:40:19 -0400
Received: from beth.pinerecords.com ([212.71.161.243]:20231 "EHLO
	beth.pinerecords.com") by vger.kernel.org with ESMTP
	id <S316611AbSE0NkS>; Mon, 27 May 2002 09:40:18 -0400
Date: Mon, 27 May 2002 11:24:42 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: me@vger.org
Cc: Simen Timian Thoresen <simentt@dolphinics.no>,
        linux-kernel@vger.kernel.org
Subject: Re: /dev/hd[ijkl] only using udma (not udma 100)
Message-ID: <20020527092441.GA7155@beth.pinerecords.com>
In-Reply-To: <200205271322.g4RDMgi11561@scispor.dolphinics.no> <Pine.LNX.4.21.0205271606390.7794-100000@kenny.worldonline.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
X-OS: GNU/Linux 2.4.19-pre8-ac5 
X-Architecture: i586
X-Uptime: 11:03
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It would realy be nice to find a way to force transfer mode on boot up but
> i cant see to find any way.

I've been using "ide2=ata66" to force ATA66/ATA100 transfer modes
on a Promise Ultra100 TX2 controller.

T.
