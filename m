Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRBBLpM>; Fri, 2 Feb 2001 06:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129460AbRBBLpC>; Fri, 2 Feb 2001 06:45:02 -0500
Received: from smtp3.xs4all.nl ([194.109.127.132]:61444 "EHLO smtp3.xs4all.nl")
	by vger.kernel.org with ESMTP id <S129406AbRBBLor>;
	Fri, 2 Feb 2001 06:44:47 -0500
Date: Fri, 2 Feb 2001 11:43:34 +0000
From: "Roeland Th. Jansen" <roel@grobbebol.xs4all.nl>
To: Mark Orr <markorr@intersurf.com>
Cc: linux-kernel@vger.kernel.org, arobinso@nyx.net, miquels@cistron.nl
Subject: Re: esp causing crashes..
Message-ID: <20010202114334.A1877@grobbebol.xs4all.nl>
In-Reply-To: <20010201231806.B2684@grobbebol.xs4all.nl> <XFMail.20010202034407.markorr@intersurf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <XFMail.20010202034407.markorr@intersurf.com>; from markorr@intersurf.com on Fri, Feb 02, 2001 at 03:44:07AM -0600
X-OS: Linux grobbebol 2.4.1-ac1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2001 at 03:44:07AM -0600, Mark Orr wrote:
> Well that surely shouldnt happen...I use minicom all the time (I still
> call BBSes), and havent had any crashes.  I can quit/disconnect, or 
> quit/stay connected and it works okay.   I've even got it set up to
> use 230000bps, which is the max my Zoom will take.


I'll try the suggestions you sent. regarding the esp -- iI foirgot to
mention that it also crashes when I unplug the connection from a router
and reconnect to the E2864i. it even sometimes crashes when somebody
calls in (e.g. faxes are received) or if I push the front switches that
emit data to the esp card.

weird. note that I use OSS drivers, not builtin sound. maybe an option
to check out too. to me it sounds like corruption in memory that causes
the crash.
-- 
Grobbebol's Home                   |  Don't give in to spammers.   -o)
http://www.xs4all.nl/~bengel       | Use your real e-mail address   /\
Linux 2.2.16 SMP 2x466MHz / 256 MB |        on Usenet.             _\_v  
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
