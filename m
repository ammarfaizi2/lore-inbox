Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270819AbRHNUaX>; Tue, 14 Aug 2001 16:30:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270817AbRHNUaN>; Tue, 14 Aug 2001 16:30:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:1541 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270808AbRHNU36>; Tue, 14 Aug 2001 16:29:58 -0400
Subject: Re: NTFS R-Only error
To: aquamodem@ameritech.net (watermodem)
Date: Tue, 14 Aug 2001 21:32:37 +0100 (BST)
Cc: linux-kernel@vger.kernel.org (linux-kernel@vger.kernel.org)
In-Reply-To: <no.id> from "watermodem" at Aug 14, 2001 11:09:20 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15Wkrd-0001tF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I am not sure who currently maintains the NTFS driver so I am posting it
> here. It doesn't look to be in the kernel so maybe mount or shell?

It looks like you fed random files to strings and it tried to parse them as
x86 elf files. See the man page and tell it they are raw binary
