Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262168AbREQBtf>; Wed, 16 May 2001 21:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262169AbREQBtZ>; Wed, 16 May 2001 21:49:25 -0400
Received: from [209.250.53.112] ([209.250.53.112]:22532 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S262168AbREQBtH>; Wed, 16 May 2001 21:49:07 -0400
Date: Wed, 16 May 2001 20:48:29 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cmpci sound chip lockup
Message-ID: <20010516204829.B828@hapablap.dyn.dhs.org>
In-Reply-To: <3B02FE4D.2F7A8E8F@gcecisp.com> <Pine.LNX.4.33.0105162000420.5251-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0105162000420.5251-100000@duckman.distro.conectiva>; from riel@conectiva.com.br on Wed, May 16, 2001 at 08:02:06PM -0300
X-Uptime: 7:42pm  up 6 min,  1 user,  load average: 1.57, 1.22, 0.55
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a "me, too" here.  I see this when using the in-kernel driver.  I'm
now using... 4.12, I think.  At any rate, the error doesn't occur, or at
least occurs to rarely as to escape notice, with this driver.  Might I
suggest the kernel's version be upgraded?  The updated driver was posted
here on lkml some time ago.

On Wed, May 16, 2001 at 08:02:06PM -0300, Rik van Riel wrote:
> On Wed, 16 May 2001, virii wrote:
> 
> > The attatched file is the format for reporting bugs.
> 
> Too bad my mailreader doesn't quote that thing .. oh well, lets
> just replace your bugreport with mine ;)
> 
> I'm seeing a similar thing on 2.4.4-pre[23], but in a far less
> serious way. Using xmms the music stops after anything between
> a few seconds and a minute, I suspect a race condition somewhere.
> 
> Using mpg123 everything works fine...
> 
> regards,
> 
> Rik
> --
> Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml
> 
> Virtual memory is like a game you can't win;
> However, without VM there's truly nothing to lose...
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
