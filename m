Return-Path: <linux-kernel-owner+w=401wt.eu-S1751252AbXAUR3y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbXAUR3y (ORCPT <rfc822;w@1wt.eu>);
	Sun, 21 Jan 2007 12:29:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbXAUR3y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Jan 2007 12:29:54 -0500
Received: from lucidpixels.com ([66.45.37.187]:59629 "EHLO lucidpixels.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751225AbXAUR3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Jan 2007 12:29:53 -0500
Date: Sun, 21 Jan 2007 12:29:51 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34.internal.lan
To: thunder7@xs4all.nl
cc: Avuton Olrich <avuton@gmail.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Subject: Re: 2.6.19.2, cp 18gb_file 18gb_file.2 = OOM killer, 100% reproducible
 (multi-threaded USB no go)
In-Reply-To: <Pine.LNX.4.64.0701211208310.15334@p34.internal.lan>
Message-ID: <Pine.LNX.4.64.0701211228320.3666@p34.internal.lan>
References: <Pine.LNX.4.64.0701201516450.3684@p34.internal.lan>
 <3aa654a40701201245s72b2f76hc70ddd94b70ba99c@mail.gmail.com>
 <Pine.LNX.4.64.0701201602570.4910@p34.internal.lan> <20070121155219.GA7413@amd64.of.nowhere>
 <Pine.LNX.4.64.0701211146530.15334@p34.internal.lan> <20070121170249.GA19956@amd64.of.nowhere>
 <Pine.LNX.4.64.0701211208310.15334@p34.internal.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Jan 2007, Justin Piszcz wrote:

> 
> 
> > 
> > Good luck,
> > Jurriaan
> > -- 
> > > What does ELF stand for (in respect to Linux?)
> > ELF is the first rock group that Ronnie James Dio performed with back in 
> > the early 1970's.  In constrast, a.out is a misspelling	 of the French word 
> > for the month of August.  What the two have in common is beyond me, but 
> > Linux users seem to use the two words together.
> > 	seen on c.o.l.misc
> > Debian (Unstable) GNU/Linux 2.6.20-rc5 2x2011 bogomips load 0.83
> > the Jack Vance Integral Edition: http://www.integralarchive.org
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-raid" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > 
> 
> Thanks, I'll give it another go in a bit!
> 
> Justin.
> -

Running 2.6.20-rc5 now, the multi-threaded USB probing causes my UPS not 
to work, probably because udev has problems or something, it is also the 
only USB device I have plugged into the machine.

In other news, I will try that copy test again.

Justin.


