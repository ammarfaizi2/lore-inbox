Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316342AbSIJQww>; Tue, 10 Sep 2002 12:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316582AbSIJQwv>; Tue, 10 Sep 2002 12:52:51 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:457 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S316342AbSIJQws>;
	Tue, 10 Sep 2002 12:52:48 -0400
Date: Tue, 10 Sep 2002 18:56:43 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Matthew Dharm <mdharm-kernel@one-eyed-alien.net>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020910185643.A9912@ucw.cz>
References: <Pine.LNX.4.44.0209091926320.1911-100000@home.transmeta.com> <Pine.LNX.4.44.0209101044060.3793-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0209101044060.3793-100000@hawkeye.luckynet.adm>; from thunder@lightweight.ods.org on Tue, Sep 10, 2002 at 10:46:27AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 10:46:27AM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Mon, 9 Sep 2002, Linus Torvalds wrote:
> > I'm personally in X 99% of the time except for the reasonably rare case
> > when I'm chasing down some bug I know I can reproduce and I want the
> > kernel to have access to the console.
> > 
> > And I doubt I'm alone in that. I suspect most people who use Linux in any
> > interesting situation (and no, I don't think servers are very interesting
> > from most standpoints) tend to do this. Agreed?
> 
> Our gatekeeper has never even heard of X. And no, I wouldn't call it a 
> server. The only thing it does is to control which doors and gates are 
> open and which are closed, and whether or not the runaway is free...

So you wanted to say that you'd prefer the machine to crash on a BUG()
than try to keep going in case of a recoverable error? I don't think
you'd like to stay locked in. At least that was what this discussion was
about.

-- 
Vojtech Pavlik
SuSE Labs
