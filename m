Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264342AbRFHUUU>; Fri, 8 Jun 2001 16:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264330AbRFHUUK>; Fri, 8 Jun 2001 16:20:10 -0400
Received: from fe3.rdc-kc.rr.com ([24.94.163.50]:12 "EHLO mail3.kc.rr.com")
	by vger.kernel.org with ESMTP id <S264339AbRFHUT6>;
	Fri, 8 Jun 2001 16:19:58 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [driver] New life for Serial mice
In-Reply-To: <20010606125556.A1766@suse.cz> <20010606232133.E38@toy.ucw.cz>
	<20010608181521.A1998@suse.cz>
	<20010608182046.H13825@atrey.karlin.mff.cuni.cz>
	<20010608182807.B2083@suse.cz>
From: Mike Coleman <mkc@mathdogs.com>
Date: 08 Jun 2001 15:19:46 -0500
In-Reply-To: <20010608182807.B2083@suse.cz>
Message-ID: <87wv6mn2ql.fsf@mathdogs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:
> > Can't it make mouse jump forward and back when user suddenly stops?
> 
> In theory - yes. It doesn't seem to be a problem in practice, though.
> It'll happen when a user slows down the mouse pointer motion faster than
> exponentially (base 2). I haven't been able to stop that fast.

Put a big brick on your desktop and *ram* it with your mouse.  :-)

-- 
Mike Coleman, mkc@mathdogs.com
  http://www.mathdogs.com -- problem solving, expert software development
