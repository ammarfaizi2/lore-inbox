Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312575AbSDSOWV>; Fri, 19 Apr 2002 10:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312576AbSDSOWU>; Fri, 19 Apr 2002 10:22:20 -0400
Received: from borg.org ([208.218.135.231]:6533 "HELO borg.org")
	by vger.kernel.org with SMTP id <S312575AbSDSOWT>;
	Fri, 19 Apr 2002 10:22:19 -0400
Date: Fri, 19 Apr 2002 10:22:19 -0400
From: Kent Borg <kentborg@borg.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: "Dr. Death" <drd@homeworld.ath.cx>, linux-kernel@vger.kernel.org
Subject: Re: A CD with errors (scratches etc.) blocks the whole system while reading damadged files
Message-ID: <20020419102219.E21727@borg.org>
In-Reply-To: <3CBEC67F.3000909@filez> <Pine.LNX.3.95.1020419100917.724A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 19, 2002 at 10:14:41AM -0400, Richard B. Johnson wrote:
> On Thu, 18 Apr 2002, Dr. Death wrote:
> 
> > Problem:
> > 
> > I use SuSE Linux 7.2 and when I create md5sums from damaged files on a 
> > CD, the WHOLE system  freezes or is ugly slow untill md5 has passed the 
> > damaged part of the file !
> > 
> 
> So what do you suggest? You can see from the logs that the device
> is having difficulty  reading your damaged CD. You can do what
> Windows-95 does (ignore the errors and pretend everything is fine),
> or what Windows-98 and Windows-2000/Prof does (blue-screen, and re-boot),
> or you can try like hell to read the files like Linux does. What do you
> suggest?

You didn't ask me, but I would still suggest that it would be nice if
the whole system didn't come to a near halt.


-kb, the Kent who wonders of the preemption patch might help here.
