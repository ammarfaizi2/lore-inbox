Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262103AbRETRSd>; Sun, 20 May 2001 13:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262102AbRETRSX>; Sun, 20 May 2001 13:18:23 -0400
Received: from m58-mp1-cvx1c.col.ntl.com ([213.104.76.58]:14208 "EHLO
	[213.104.76.58]") by vger.kernel.org with ESMTP id <S262101AbRETRSJ>;
	Sun, 20 May 2001 13:18:09 -0400
To: Alexander Viro <viro@math.psu.edu>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: no ioctls for serial ports? [was Re: LANANA: To Pending DeviceNumberRegistrants]
In-Reply-To: <Pine.GSO.4.21.0105200833270.8940-100000@weyl.math.psu.edu>
From: John Fremlin <vii@users.sourceforge.net>
Date: 20 May 2001 18:17:57 +0100
In-Reply-To: <Pine.GSO.4.21.0105200833270.8940-100000@weyl.math.psu.edu> (Alexander Viro's message of "Sun, 20 May 2001 08:45:47 -0400 (EDT)")
Message-ID: <m2vgmwym62.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Alexander Viro <viro@math.psu.edu> writes:

[...]

> We have ~180 first-order ioctl() methods. Several (my guess would be

Hehe. I suppose you already know about the way strace (@sourceforge)
kind of automatically tries to figure out the args for the common
ones?

[...]

-- 

	http://ape.n3.net
