Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132540AbRDUJNp>; Sat, 21 Apr 2001 05:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132547AbRDUJNf>; Sat, 21 Apr 2001 05:13:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:46090 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132540AbRDUJN2>; Sat, 21 Apr 2001 05:13:28 -0400
Subject: Re: Linux 2.4.3-ac11
To: jamagallon@able.es (J . A . Magallon)
Date: Sat, 21 Apr 2001 10:15:20 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010421030930.A29461@werewolf.able.es> from "J . A . Magallon" at Apr 21, 2001 03:09:30 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qtUA-0003IS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On 04.21 Alan Cox wrote:
> > 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/alan/2.4/
> 
> gcc-2.96 spits warnings about possibly-used-before-initialized vars in
> mtrr.c, line 2004:

Its right actually... that could only bite what I believe to be never issued
chips but its right.

