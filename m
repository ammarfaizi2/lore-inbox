Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130393AbQLWICH>; Sat, 23 Dec 2000 03:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbQLWIB5>; Sat, 23 Dec 2000 03:01:57 -0500
Received: from c266492-a.lakwod1.co.home.com ([24.1.8.253]:33549 "EHLO
	benatar.snurgle.org") by vger.kernel.org with ESMTP
	id <S130393AbQLWIBs>; Sat, 23 Dec 2000 03:01:48 -0500
Date: Sat, 23 Dec 2000 02:30:29 -0500 (EST)
From: William T Wilson <fluffy@snurgle.org>
To: Chris Wedgwood <cw@f00f.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Arg.  File > 2GB removal
In-Reply-To: <Pine.LNX.4.21.0012230224170.14237-100000@benatar.snurgle.org>
Message-ID: <Pine.LNX.4.21.0012230229290.14237-100000@benatar.snurgle.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Dec 2000, William T Wilson wrote:

> If that's true, then the following C programlet should remove the file:

I lied.  You need to include <unistd.h> not <stdlib.h>

Oh no!  This is linux-kernel.  I thought it was debian-user.  Sorry,
didn't mean to waste bandwidth :}

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
