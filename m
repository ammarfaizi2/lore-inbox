Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263286AbREWWIp>; Wed, 23 May 2001 18:08:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263287AbREWWIf>; Wed, 23 May 2001 18:08:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:17165 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263286AbREWWI3>; Wed, 23 May 2001 18:08:29 -0400
Subject: Re: [PATCH] big-sector support with FAT
To: hirofumi@mail.parknet.co.jp (OGAWA Hirofumi)
Date: Wed, 23 May 2001 23:05:11 +0100 (BST)
Cc: torvalds@transmeta.com (Linus Torvalds),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <87lmnn97i4.fsf@devron.myhome.or.jp> from "OGAWA Hirofumi" at May 24, 2001 04:42:59 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E152gkh-00048O-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I fixed it to dynamically change block size with logical_sector_size
> of FAT. The device of bigger sector-size than 512 can be handled by
> this change.

I am so glad someone did that.

> Please apply.

Gladly
