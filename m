Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129679AbQJ1KdA>; Sat, 28 Oct 2000 06:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130109AbQJ1Kcu>; Sat, 28 Oct 2000 06:32:50 -0400
Received: from client38155.atl.mediaone.net ([24.88.38.155]:48632 "HELO
	whitestar.soark.net") by vger.kernel.org with SMTP
	id <S129679AbQJ1Kcm>; Sat, 28 Oct 2000 06:32:42 -0400
Date: Sat, 28 Oct 2000 06:32:38 -0400
From: kernel@whitestar.soark.net
To: Burton Windle <burton@fint.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [drm:drm_release] *ERROR* Process 256 dead
Message-ID: <20001028063238.A32511@whitestar.soark.net>
Reply-To: warp@whitestar.soark.net
In-Reply-To: <Pine.LNX.4.21.0010232316300.12884-100000@fint.staticky.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0010232316300.12884-100000@fint.staticky.com>; from burton@fint.org on Mon, Oct 23, 2000 at 11:22:53PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 23, 2000 at 11:22:53PM -0400, Burton Windle wrote:
> Sorry if this is user-error, but after about 20min of using
> 2.4.0-test10-pre5, my Debian Woody system dropped out of X with this
> message in syslog:
> 
> [drm:drm_release] *ERROR* Process 256 dead, freeing lock for context 1
> 
> I've never seen this before; I had been using test10-pre4 for several days
> without error.
> 
> Is this a kernel bugglet/error, or X?

Could you please send me the /var/log/XFree86.0.log from the crash, as
well as your /etc/X11/XF86Config-4?

Thanks.
Zephaniah E. Hull.
(The Debian 3Dfx guy, who generally does not do X, but gets to anyways)
> 
> -- 
> Burton Windle				burton@fint.org
> Linux: the "grim reaper of innocent orphaned children."
>           from /usr/src/linux/init/main.c:1384
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
