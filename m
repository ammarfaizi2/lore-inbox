Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280664AbRKBLvq>; Fri, 2 Nov 2001 06:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280662AbRKBLv0>; Fri, 2 Nov 2001 06:51:26 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:15620 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280661AbRKBLvX>; Fri, 2 Nov 2001 06:51:23 -0500
Subject: Re: where the filesystem size limitation coms from?
To: zmwillow@xteamlinux.com.cn (zmwillow)
Date: Fri, 2 Nov 2001 11:57:37 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel-mail-list),
        reiser@namesys.com (hans reiser)
In-Reply-To: <3BE2B5F2.1040009@xteamlinux.com.cn> from "zmwillow" at Nov 02, 2001 03:04:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15zcx7-00023V-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And the max file size now biger than 2G(is 16T), how reiserfs implement it?
> Thanx a lot!

16Tb etc are file system internal limits. There is also a 1Tb or so block
device limit too
