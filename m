Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRFIJKc>; Sat, 9 Jun 2001 05:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264446AbRFIJKV>; Sat, 9 Jun 2001 05:10:21 -0400
Received: from olsinka.site.cas.cz ([147.231.11.16]:6784 "EHLO
	twilight.suse.cz") by vger.kernel.org with ESMTP id <S264445AbRFIJKJ>;
	Sat, 9 Jun 2001 05:10:09 -0400
Date: Sat, 9 Jun 2001 11:01:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Mike Coleman <mkc@mathdogs.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [driver] New life for Serial mice
Message-ID: <20010609110153.A669@suse.cz>
In-Reply-To: <20010606125556.A1766@suse.cz> <20010606232133.E38@toy.ucw.cz> <20010608181521.A1998@suse.cz> <20010608182046.H13825@atrey.karlin.mff.cuni.cz> <20010608182807.B2083@suse.cz> <87wv6mn2ql.fsf@mathdogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87wv6mn2ql.fsf@mathdogs.com>; from mkc@mathdogs.com on Fri, Jun 08, 2001 at 03:19:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2001 at 03:19:46PM -0500, Mike Coleman wrote:

> Vojtech Pavlik <vojtech@suse.cz> writes:
> > > Can't it make mouse jump forward and back when user suddenly stops?
> > 
> > In theory - yes. It doesn't seem to be a problem in practice, though.
> > It'll happen when a user slows down the mouse pointer motion faster than
> > exponentially (base 2). I haven't been able to stop that fast.
> 
> Put a big brick on your desktop and *ram* it with your mouse.  :-)

Cool idea! Gotta try ... ;)

-- 
Vojtech Pavlik
SuSE Labs
