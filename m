Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289282AbSBNBA2>; Wed, 13 Feb 2002 20:00:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289272AbSBNBAV>; Wed, 13 Feb 2002 20:00:21 -0500
Received: from ns1.intercarve.net ([216.254.127.221]:4897 "HELO
	ceramicfrog.intercarve.net") by vger.kernel.org with SMTP
	id <S287631AbSBNBAN>; Wed, 13 Feb 2002 20:00:13 -0500
Date: Wed, 13 Feb 2002 19:56:00 -0500 (EST)
From: "Drew P. Vogel" <dvogel@intercarve.net>
To: "J.S.S." <jss@pacbell.net>
Cc: Steve Kieu <haiquy@yahoo.com>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: Unable to compile 2.5.4: "control reaches end of non-void
 functionm"
In-Reply-To: <PGEMINDOPMDNMJINCKBNAEDCCBAA.jss@pacbell.net>
Message-ID: <Pine.LNX.4.33.0202131955210.17093-100000@northface.intercarve.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If it is in processor.h, search the archives. There was a patch for this
submitted to the list about a week ago.

--Drew Vogel

On Wed, 13 Feb 2002, J.S.S. wrote:

>I have this same problem on both my laptop and my testbox.  It happens
>everytime and I have yet to compile 2.5.4 successfully.  Although, I suspect
>it's in my config file - I'm just using an old config file I used for my
>2.4.17 kernel which works just fine.
>
>-----Original Message-----
>From: linux-kernel-owner@vger.kernel.org
>[mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Steve Kieu
>Sent: Tuesday, February 12, 2002 8:49 PM
>To: kernel
>Subject: Re: Unable to compile 2.5.4: "control reaches end of non-void
>functionm"
>
>
>
>Hi,
>
>It seems nobody having this problem? No one replies at
>least why, so I just want to add one more case of
>compiling error. Exactly the same message as yours.
>
>
>
>=====
>S.KIEU
>
>http://greetings.yahoo.com.au - Yahoo! Greetings
>- Send your Valentines love online.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>

--Drew Vogel

