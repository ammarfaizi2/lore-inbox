Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271792AbRH3JLv>; Thu, 30 Aug 2001 05:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271791AbRH3JLb>; Thu, 30 Aug 2001 05:11:31 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:40718 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271741AbRH3JLW>; Thu, 30 Aug 2001 05:11:22 -0400
Subject: Re: ioctl conflicts
To: davem@redhat.com (David S. Miller)
Date: Thu, 30 Aug 2001 10:14:45 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, manik@cisco.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010830.013023.94071732.davem@redhat.com> from "David S. Miller" at Aug 30, 2001 01:30:23 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15cNuP-0000mP-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>    Thats fine. ext2 ioctls and video ioctls go to different places
> Consider sparc64.

If the ioctl translation layer can't handle duplicates it has bigger
problems than that

