Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281504AbRKMGDI>; Tue, 13 Nov 2001 01:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281529AbRKMGC6>; Tue, 13 Nov 2001 01:02:58 -0500
Received: from mail203.mail.bellsouth.net ([205.152.58.143]:36012 "EHLO
	imf03bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S281504AbRKMGCv>; Tue, 13 Nov 2001 01:02:51 -0500
Message-ID: <3BF0B776.4EE31B94@mandrakesoft.com>
Date: Tue, 13 Nov 2001 01:02:30 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com> <15344.46456.814742.182373@notabene.cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:
> I'm still lamenting the loss of the "-Werror" compile switch....

Me too but the kernel won't build basic stuff in fs/*.c code on 64-bit
platforms with it enabled...

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

