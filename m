Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132569AbRAXRZy>; Wed, 24 Jan 2001 12:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131984AbRAXRZp>; Wed, 24 Jan 2001 12:25:45 -0500
Received: from post.it.helsinki.fi ([128.214.205.24]:41233 "EHLO
	post.it.helsinki.fi") by vger.kernel.org with ESMTP
	id <S132569AbRAXRZf>; Wed, 24 Jan 2001 12:25:35 -0500
Date: Wed, 24 Jan 2001 19:33:37 +0200
From: Robert Holmberg <robert.holmberg@helsinki.fi>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nividia fb 0.9.0?
Message-ID: <20010124193337.A18625@chefren>
In-Reply-To: <20010124174558.A6608@chefren> <3A6EF86B.32F6DC1E@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3A6EF86B.32F6DC1E@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Wed, Jan 24, 2001 at 17:44:43 +0200
X-Mailer: Balsa 1.1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001.01.24 17:44:43 +0200 Jeff Garzik wrote:
> I just mentioned this to Bakonyi Ferenc <fero@drama.obuda.kando.hu>, who
> said that it would be better to roll a new patch without the v4l stuff,
> and update rivafb.  rivafb is apparently stable but the v4l code is not
> (yet).

I can't wait to finally get a usable rivafb. Previous versions 
have been both buggy and catastophically slow. This version 
(0.9.0) was fast enough to make things work as smoothly as 
without a framebuffer device. 

B.T.W. is there any way of getting the text-only mode 
working and still having fb available for, say, having 
fbtv (tv tuner for fb devices) running at one console 
while the other consoles would still be using text mode?

Robert.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
