Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280669AbRKNP6a>; Wed, 14 Nov 2001 10:58:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280682AbRKNP6U>; Wed, 14 Nov 2001 10:58:20 -0500
Received: from mail311.mail.bellsouth.net ([205.152.58.171]:51051 "EHLO
	imf11bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280676AbRKNP6L>; Wed, 14 Nov 2001 10:58:11 -0500
Message-ID: <3BF2947B.DF3BE9DC@mandrakesoft.com>
Date: Wed, 14 Nov 2001 10:57:47 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Stuart MacDonald <stuartm@connecttech.com>
CC: tytso@mit.edu, rmk@arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: Fw: [Patch] Some updates to serial-5.05
In-Reply-To: <00df01c16d23$b409ab20$294b82ce@connecttech.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Your code formatting is totally different from the formatting of the
surrounding serial.c code you modify.

Also, a diff against the kernel 2.4.x serial.c might be nice, as there
haven't been updates from tytso in ages (serial-5.05), and rmk has a new
serial driver for 2.5.x.

	Jeff



-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

