Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282498AbRLAXzC>; Sat, 1 Dec 2001 18:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282502AbRLAXyw>; Sat, 1 Dec 2001 18:54:52 -0500
Received: from cc361913-a.flrtn1.occa.home.com ([24.0.193.171]:11139 "EHLO
	mirai.cx") by vger.kernel.org with ESMTP id <S282498AbRLAXyd>;
	Sat, 1 Dec 2001 18:54:33 -0500
Message-ID: <3C096DB3.204CE41C@pobox.com>
Date: Sat, 01 Dec 2001 15:54:27 -0800
From: J Sloan <jjs@pobox.com>
Organization: J S Concepts
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Merkey <jmerkey@timpanogas.org>
CC: Charles-Edouard Ruault <ce@ruault.com>, linux-kernel@vger.kernel.org
Subject: Re: File system Corruption with 2.4.16
In-Reply-To: <3C0954D5.6AA3532B@ruault.com> <3C09580F.5F323195@pobox.com> <3C095B0B.7EA478C1@ruault.com> <003601c17ac2$7a8dec10$f5976dcf@nwfs>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Merkey wrote:

> I am seeing corruption on 2.4.16 (2.4.17-pre1/2) as well.  Whatever this
> gentlemen is doing is making it show up quicker, but I am on my fourth
> interation of fsck'ing 2.4.16 on my production server with NWFS builds.  I
> am looking through Al Viros's inode code changes to see if there's hole
> somewhere.  This problem appears to be related to low memory conditions.  I
> see it when memory is getting low.  May be VM related as well.

Just to be positive, can you reproduce the
problem without nwfs?

cu

jjs

