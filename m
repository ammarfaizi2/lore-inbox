Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292955AbSCKUud>; Mon, 11 Mar 2002 15:50:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292983AbSCKUuX>; Mon, 11 Mar 2002 15:50:23 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:12548 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292955AbSCKUuI>;
	Mon, 11 Mar 2002 15:50:08 -0500
Date: Mon, 11 Mar 2002 17:49:43 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Martin Dalecki <martin@dalecki.de>,
        Linus Torvalds <torvalds@transmeta.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [patch] My AMD IDE driver, v2.7
In-Reply-To: <3C8CDD02.3060907@evision-ventures.com>
Message-ID: <Pine.LNX.4.44L.0203111748090.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Mar 2002, Martin Dalecki wrote:
> Vojtech Pavlik wrote:

> > This patch replaces the current AMD IDE driver (by Andre Hedrick) by
> > mine.

> Agreed. Let's give it a try. (This is trivial to back up.)

I think experience has tought us by now that large changes in
code are impossible to completely back out or debug.

Then again, after reading your discussion with Alan I guess
we don't have much too lose anyway.

regards,

Rik
-- 
<insert bitkeeper endorsement here>

http://www.surriel.com/		http://distro.conectiva.com/

