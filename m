Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbRGPTfu>; Mon, 16 Jul 2001 15:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267691AbRGPTfl>; Mon, 16 Jul 2001 15:35:41 -0400
Received: from ls212.hinet.hr ([195.29.150.91]:38874 "EHLO ls212.hinet.hr")
	by vger.kernel.org with ESMTP id <S267695AbRGPTf0>;
	Mon, 16 Jul 2001 15:35:26 -0400
Date: Mon, 16 Jul 2001 21:34:52 +0200
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:blinking screen in XFree4.x !
Message-ID: <20010716213452.A700@debelian.doma.hr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107161128050.579-100000@desktop>
User-Agent: Mutt/1.3.18i
From: Marko Rebrina <mrebrina@jagor.srce.hr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 16, 2001 at 11:28:59AM -0700, Jeffrey W. Baker wrote:
> On Mon, 16 Jul 2001, Marko Rebrina wrote:
> > Hi,
> > I have problem with XFree4.x(current 4.1) when I have large file transfer(~1GB)
> > then screen in X start blinking(black screen),console works fine!
> > Restarting Xe not resolving problem! No message in log !
> I used to have this problem as well.  It is due to massive clock skew on
> certain motherboads (ahem).  To "fix" this, simply display DPMS in your X
> server: xset -dpms

Nope, not help! In FreeBSD with XFree86-4 I don't have this problem!

-- 
  -o)      // Marko Rebrina, http://jagor.srce.hr/~mrebrina, ICQ:20358351 \\
  /\\  
 _\_v      Serving FREE beer to the users of the FREE Linux of a FREE world
