Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264517AbRFJLJj>; Sun, 10 Jun 2001 07:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264521AbRFJLJ3>; Sun, 10 Jun 2001 07:09:29 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:7172 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S264518AbRFJLJX>;
	Sun, 10 Jun 2001 07:09:23 -0400
Message-ID: <20010608225744.A17144@bug.ucw.cz>
Date: Fri, 8 Jun 2001 22:57:44 +0200
From: Pavel Machek <pavel@suse.cz>
To: Mike Coleman <mkc@mathdogs.com>, Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (driver) New life for Serial mice
In-Reply-To: <20010606125556.A1766@suse.cz> <20010606232133.E38@toy.ucw.cz> <20010608181521.A1998@suse.cz> <20010608182046.H13825@atrey.karlin.mff.cuni.cz> <20010608182807.B2083@suse.cz> <87wv6mn2ql.fsf@mathdogs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <87wv6mn2ql.fsf@mathdogs.com>; from Mike Coleman on Fri, Jun 08, 2001 at 03:19:46PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > Can't it make mouse jump forward and back when user suddenly stops?
> > 
> > In theory - yes. It doesn't seem to be a problem in practice, though.
> > It'll happen when a user slows down the mouse pointer motion faster than
> > exponentially (base 2). I haven't been able to stop that fast.
> 
> Put a big brick on your desktop and $ram$ it with your mouse.  :-)

:-)))))))))))))))))))))

Put warning in Configure.help that this driver is not compatible with
certain kinds of bricks ;-))))).
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
