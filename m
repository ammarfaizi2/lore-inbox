Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261860AbRESQdh>; Sat, 19 May 2001 12:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261864AbRESQd1>; Sat, 19 May 2001 12:33:27 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:64267 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S261860AbRESQdQ>;
	Sat, 19 May 2001 12:33:16 -0400
Date: Sat, 19 May 2001 13:33:10 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Negative inode-nr ?
In-Reply-To: <20010519171901.A10204@unthought.net>
Message-ID: <Pine.LNX.4.21.0105191332150.5531-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 May 2001, [iso-8859-1] Jakob Østergaard wrote:

> What do you think of this ?
> [root]# cat /proc/sys/fs/inode-nr 
> 157097	-180

I think you should upgrade to a newer kernel; Al Viro
fixed this bug and the fix went into 2.4.5-pre1.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

