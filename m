Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312718AbSECNjP>; Fri, 3 May 2002 09:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312928AbSECNjO>; Fri, 3 May 2002 09:39:14 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:35336 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S312718AbSECNjN>; Fri, 3 May 2002 09:39:13 -0400
Message-Id: <200205031337.g43DbT906318@aslan.scsiguy.com>
To: Dave Jones <davej@suse.de>
cc: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.12-dj1 
In-Reply-To: Your message of "Thu, 02 May 2002 14:54:56 +0200."
             <20020502145456.B16935@suse.de> 
Date: Fri, 03 May 2002 07:37:29 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Is it appropriate to edit .config to use the new driver by setting:
> > CONFIG_SCSI_AIC7XXX=y
> > CONFIG_AIC7XXX_CMDS_PER_DEVICE=253
> > CONFIG_AIC7XXX_RESET_DELAY_MS=15000
> > Is the new driver experimental, or ?
>
>I've no experience of either driver in practice, so I'm not actually
>sure what the game plan is here. Someone want to fill us in? Justin?

Since I have not reviewed how the driver has been modified for 2.5,
I can't really say much about its status in that branch.  The driver
is not "experimental" in the 2.4 branch.

--
Justin
