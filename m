Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281076AbRKDSfC>; Sun, 4 Nov 2001 13:35:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281072AbRKDSe4>; Sun, 4 Nov 2001 13:34:56 -0500
Received: from postfix2-2.free.fr ([213.228.0.140]:25836 "HELO
	postfix2-2.free.fr") by vger.kernel.org with SMTP
	id <S281089AbRKDSem> convert rfc822-to-8bit; Sun, 4 Nov 2001 13:34:42 -0500
Date: Sun, 4 Nov 2001 16:49:43 +0100 (CET)
From: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
X-X-Sender: <groudier@gerard>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux <linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>
Subject: Re: SYM-2 patches against latest kernels available
In-Reply-To: <3BE564A4.D88D1951@mandrakesoft.com>
Message-ID: <20011104162951.X1896-100000@gerard>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I missed to reply to your 1rst question.

On Sun, 4 Nov 2001, Jeff Garzik wrote:

> Gérard Roudier wrote:
> > The patch against linux-2.4.13 has been sent to Alan Cox for inclusion in
> > newer stable kernels. Alan wants to test it on his machines which is a
> > good thing. Anyway, those patches just add the new driver version to
> > kernel tree and leave stock sym53c8xx and ncr53c8xx in place.
>
> Are the older sym/ncr drivers going away in 2.5?

There is no valuable reasons to remove them in a hurry. But sym version 2
is intended to be a replacement of those both old driver versions. This
has to be proven so prior to removing previous stuff, in my opinion. Note
that Linus may decide differently, but for now he has accepted redundant
drivers in his tree (some seems even to stay here forever:-) ).

[...]

Regards,
  Gérard.

