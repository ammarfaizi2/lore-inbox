Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261843AbREPI6Z>; Wed, 16 May 2001 04:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261844AbREPI6P>; Wed, 16 May 2001 04:58:15 -0400
Received: from www.topmail.de ([212.255.16.226]:11197 "HELO www.topmail.de")
	by vger.kernel.org with SMTP id <S261843AbREPI6E>;
	Wed, 16 May 2001 04:58:04 -0400
From: <eccesys@topmail.de>
To: <linux-kernel@vger.kernel.org>
Subject: trailing "cd" (rgooch) and i18n (ac)
Message-Id: <20010516085331.EA982A5A8F5@www.topmail.de>
Date: Wed, 16 May 2001 10:53:31 +0200 (MET DST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, no, because it's guaranteed that a trailing "/cd" is a
> CD-ROM. That's the standard.

I don't know what a cabbage dicer is (has it to do with dices?),
but if it is guaranteed that cd is a cd, how are the arabican
device names (extend for klinzhai, chinese, japanese etc.)
supposed to be?
There should really kind of *call (maybe IOGETTYPE or so) which
can be used to get back a bitmapped set of properties of a given
device (bit0= bit1= etc.)

I remember, when I wrote a DOS Ramdisk driver, I had to set a 16bit
driver flag, too.

-mirabilos
-- 
by telnet
