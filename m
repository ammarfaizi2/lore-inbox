Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280825AbRLLPuR>; Wed, 12 Dec 2001 10:50:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280938AbRLLPuI>; Wed, 12 Dec 2001 10:50:08 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:3086 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S280825AbRLLPuB>; Wed, 12 Dec 2001 10:50:01 -0500
Subject: Re: Repost: ASUS APM Problem (ASUS L8400L & ASUS P2B-F)
To: fridtjof@fbunet.de
Date: Wed, 12 Dec 2001 15:59:25 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011209175547.GD7707@charite.de> from "fridtjof@fbunet.de" at Dec 12, 2001 09:22:43 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16EBn3-0001Ug-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> $ cat /proc/apm
> 1.14 1.2 0x03 0x01 0xff 0x80 -1% -1 ?
>                              ^^^^^^^^
-1 is "unknown"
