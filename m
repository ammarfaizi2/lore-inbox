Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282403AbRKXJBh>; Sat, 24 Nov 2001 04:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282405AbRKXJB2>; Sat, 24 Nov 2001 04:01:28 -0500
Received: from [212.18.232.186] ([212.18.232.186]:59910 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282403AbRKXJBS>; Sat, 24 Nov 2001 04:01:18 -0500
Date: Sat, 24 Nov 2001 09:00:24 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.15-pre9 breakage (inode.c)
Message-ID: <20011124090024.B8631@flint.arm.linux.org.uk>
In-Reply-To: <20011124064739.J1324@athlon.random> <Pine.LNX.4.33.0111232154320.1821-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111232154320.1821-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Nov 23, 2001 at 09:55:42PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 09:55:42PM -0800, Linus Torvalds wrote:
> I have to say that I like this patch better myself - the added tests are
> not sensible, and just removing them seems to be the right thing.

Linus,

Could we at least have a working -final kernel?  Please?

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

