Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282120AbRK1K15>; Wed, 28 Nov 2001 05:27:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282119AbRK1K1o>; Wed, 28 Nov 2001 05:27:44 -0500
Received: from [195.63.194.11] ([195.63.194.11]:52997 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S282118AbRK1K1k>; Wed, 28 Nov 2001 05:27:40 -0500
Message-ID: <3C04B9C4.957A4527@evision-ventures.com>
Date: Wed, 28 Nov 2001 11:17:40 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision.ag
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linus Torvalds <torvalds@transmeta.com>, Jens Axboe <axboe@suse.de>,
        linux-kernel@vger.kernel.org, jmerkey@timpanogas.org
Subject: Re: Block I/O Enchancements, 2.5.1-pre2
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com> <20011127183418.A812@vger.timpanogas.org> <3C0441B4.B8194BEE@mandrakesoft.com> <20011127185509.A1060@vger.timpanogas.org> <3C044CB1.62F5650F@mandrakesoft.com>
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Oh yeah, I meant to ask: do we get 64-bit inode numbers and 64-bit block
> numbers on x86 sometime in 2.5?

Well at least the patch from Jens makes this much easier...
