Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273831AbRJNCq3>; Sat, 13 Oct 2001 22:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273854AbRJNCqT>; Sat, 13 Oct 2001 22:46:19 -0400
Received: from cogito.cam.org ([198.168.100.2]:11019 "EHLO cogito.cam.org")
	by vger.kernel.org with ESMTP id <S273831AbRJNCqM>;
	Sat, 13 Oct 2001 22:46:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@CAM.ORG>
Organization: me
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
        Alexander Viro <viro@math.psu.edu>
Subject: Re: mount hanging 2.4.12
Date: Sat, 13 Oct 2001 22:41:08 -0400
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011013234121.31B3B24D64@oscar.casa.dyndns.org> <Pine.GSO.4.21.0110132157160.3903-100000@weyl.math.psu.edu> <20011013193635.B1356@one-eyed-alien.net>
In-Reply-To: <20011013193635.B1356@one-eyed-alien.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011014024108.BE1EA251BA@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On October 13, 2001 10:36 pm, Matthew Dharm wrote:
> Media change is broken for the SDDR-09 driver.  That's why it's
> experimental, among other reasons.
>
> Don't worry about that, but if you've got a non-media change related
> problem, then I would look at that.

Actually media change _worked_ with previous kernels, 2.4.10 and below.
I would get an error from one mount and the second would work.  Not
real clean but it did work...

Ed Tomlinson
