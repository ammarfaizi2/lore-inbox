Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135442AbRAGBDy>; Sat, 6 Jan 2001 20:03:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135453AbRAGBDo>; Sat, 6 Jan 2001 20:03:44 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27665 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S135442AbRAGBDg>; Sat, 6 Jan 2001 20:03:36 -0500
Message-ID: <3A57C1D5.C9E1A1F8@uow.edu.au>
Date: Sun, 07 Jan 2001 12:09:41 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test8 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Philipp Schmid <ph.schmid@aon.at>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3com mini pci card 3cn3ac556
In-Reply-To: <01010621553000.00457@dagobert>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Philipp Schmid wrote:
> 
> hi,
> 
> are there any drivers for  "3Com mini pci card 3cn3ac556", shipped with my
> dell latitude c600 ?

Yep.  Support for the 3c556 was added in kernel 2.2.17-pre14, so
you need 2.2.17 or later.

The latest driver, which is compatible with 2.2.14 and later
is at

	http://www.uow.edu.au/~andrewm/linux/3c59x.c-2.2.19pre2.gz
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
