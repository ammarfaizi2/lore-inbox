Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLOB1d>; Thu, 14 Dec 2000 20:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129325AbQLOB1X>; Thu, 14 Dec 2000 20:27:23 -0500
Received: from [209.143.110.29] ([209.143.110.29]:28168 "HELO
	mail.the-rileys.net") by vger.kernel.org with SMTP
	id <S129267AbQLOB1J>; Thu, 14 Dec 2000 20:27:09 -0500
Message-ID: <3A396C39.798939C5@the-rileys.net>
Date: Thu, 14 Dec 2000 19:56:29 -0500
From: David Riley <oscar@the-rileys.net>
Reply-To: oscar@the-rileys.net
Organization: The Rileys
X-Mailer: Mozilla 4.74 (Macintosh; U; PPC)
X-Accept-Language: en,pdf
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Miquel van Smoorenburg <miquels@traveler.cistron-office.nl>,
        linux-kernel@vger.kernel.org
Subject: Re: Linus's include file strategy redux
In-Reply-To: <Pine.GSO.4.21.0012141933390.10441-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
>         Actually, I suspect that quite a few of us had done that since long -
> IIRC I've got burned on 1.2/1.3 and decided that I had enough. Bugger if I
> remember what exactly it was - ISTR that it was restore(8) built with
> 1.3.<something> headers and playing funny games on 1.2, but it might be
> something else...

So then what's the correct header tree to put in /usr/include/linux?  I
could use the stock 2.2.14-patched headers that came with the dist, but
how often does it need to be updated?  Or should I use the latest 2.2?

-- 
"Windows for Dummies?  Isn't that redundant?"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
