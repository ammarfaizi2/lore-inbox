Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261862AbSJNIHc>; Mon, 14 Oct 2002 04:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261868AbSJNIHc>; Mon, 14 Oct 2002 04:07:32 -0400
Received: from medelec.uia.ac.be ([143.169.17.1]:25867 "EHLO medelec.uia.ac.be")
	by vger.kernel.org with ESMTP id <S261862AbSJNIHb>;
	Mon, 14 Oct 2002 04:07:31 -0400
Date: Mon, 14 Oct 2002 10:12:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: Rob Radez <rob@osinvestor.com>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers
Message-ID: <20021014101209.A18123@medelec.uia.ac.be>
References: <20021013234308.P23142@flint.arm.linux.org.uk> <Pine.LNX.4.33L2.0210131615480.22520-100000@dragon.pdx.osdl.net> <20021013215726.P16698@osinvestor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021013215726.P16698@osinvestor.com>; from rob@osinvestor.com on Sun, Oct 13, 2002 at 09:57:26PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

I have downloaded your latest patch and will use it to update the watchdog 
drivers. I'll be doing some additional cleanup and additions myself probably.

Now I'm still left with my original question: wouldn't it be easier if we
put all watchdog drivers in drivers/char/watchdog/ ?

Greetings,
Wim.

> I had to move my patches off of junker.org and back to http://osinvestor.com/
> which also changed the timestamp on the file.  I really have been meaning to
> keep the patch updated (and continue working on stuff), as well as submit
> stuff for 2.5, but I've just been really busy.  At this point, I'd be quite
> happy to let someone else submit my work for 2.5 or 2.4.
> 
> Regards,
> Rob Radez
