Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282812AbRK0FK7>; Tue, 27 Nov 2001 00:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282809AbRK0FKt>; Tue, 27 Nov 2001 00:10:49 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:26248
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S282813AbRK0FKd>; Tue, 27 Nov 2001 00:10:33 -0500
Date: Mon, 26 Nov 2001 22:10:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: olh@suse.de, marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: Re: [PATCH] net/802/Makefile
Message-ID: <20011126221012.C13091@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.21.0111261514070.13961-100000@freak.distro.conectiva> <20011126.112033.88487539.davem@redhat.com> <20011126203527.C31937@suse.de> <20011126.114045.102135510.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011126.114045.102135510.davem@redhat.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 11:40:45AM -0800, David S. Miller wrote:
>    From: Olaf Hering <olh@suse.de>
>    Date: Mon, 26 Nov 2001 20:35:27 +0100
> 
>    Can you submit that version? ;)
>    
> No, because it is writable by the user in every kernel source tree I
> have ever seen, the change makes no sense.

You haven't tried a BitKeeper tree then.  You have to explicitly get
write permission.

> In the official tarballs it is writable, and even in every CVS tree
> (2.2.x, 2.4.x vger) I have looked at it is writable.
> 
> And as Alan has stated, this code is pretty irrelevant soon.

If this rewrite goes into 2.4, yes.  And using 2.2 as an example it
could after a while...

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
