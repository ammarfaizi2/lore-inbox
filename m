Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270841AbRICBHG>; Sun, 2 Sep 2001 21:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270827AbRICBG4>; Sun, 2 Sep 2001 21:06:56 -0400
Received: from news.cistron.nl ([195.64.68.38]:10513 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id <S270822AbRICBGp>;
	Sun, 2 Sep 2001 21:06:45 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: ioctl conflicts
Date: 3 Sep 2001 03:06:57 +0200
Organization: Cistron Internet Services
Message-ID: <9mul3h$gkr$1@picard.cistron.nl>
In-Reply-To: <3B8DEF9D.26F7544D@cisco.com> <E15cN49-0000fz-00@the-village.bc.nu>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E15cN49-0000fz-00@the-village.bc.nu>,
Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
>Thats fine. ext2 ioctls and video ioctls go to different places

For some values of fine only, it sucks if you are strace.

Wichert.


-- 
  _________________________________________________________________
 /       Nothing is fool-proof to a sufficiently talented fool     \
| wichert@wiggy.net                   http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

