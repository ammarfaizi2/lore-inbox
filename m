Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbREUURQ>; Mon, 21 May 2001 16:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261664AbREUURH>; Mon, 21 May 2001 16:17:07 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:24068 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S261640AbREUURC>;
	Mon, 21 May 2001 16:17:02 -0400
Message-ID: <20010520225303.D2647@bug.ucw.cz>
Date: Sun, 20 May 2001 22:53:03 +0200
From: Pavel Machek <pavel@suse.cz>
To: Willem Konynenberg <wfk@xos.nl>, Abramo Bagnara <abramo@alsa-project.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: Why side-effects on open(2) are evil. (was Re: [RFD w/info-PATCH]device arguments from lookup)
In-Reply-To: <3B068D00.95338099@alsa-project.org> <200105191601.SAA04009@rabbit.xos.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <200105191601.SAA04009@rabbit.xos.nl>; from Willem Konynenberg on Sat, May 19, 2001 at 06:01:06PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> So I guess things have already been a bit messy in this
> area for many years, even before linux even existed, and
> in some cases you can't really do anything about it because
> the behaviour is mandated by the applicable standards, like
> POSIX, SUS, or whatever.
> (The blocking of the open on a tty device is explicitly
>  documented in my copy of the X/Open specification.)

If X/Open documents security hole, then, I guess, X/Open will have to
be changed.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
