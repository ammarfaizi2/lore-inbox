Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSHXSyb>; Sat, 24 Aug 2002 14:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSHXSyb>; Sat, 24 Aug 2002 14:54:31 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:49068 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S316609AbSHXSya>; Sat, 24 Aug 2002 14:54:30 -0400
Message-ID: <20020824185838.2961.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: conman@kolivas.net, linux-kernel@vger.kernel.org
Date: Sun, 25 Aug 2002 02:58:38 +0800
Subject: Re: Combined performance patches update for 2.4.19
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: conman@kolivas.net
Date: Sat, 24 Aug 2002 22:21:37 +1000

> > > > BTW, thank you for your great work!!
> > > 
> > > My pleasure, but really the hard work is done by the developers!
> > Sure, but your "performance" approach is really intersting! Do you use a
> > benchmark?
> 
> I don't really have the time to benchmark these things any more than "it feels
> faster". Really I'm spending way too much time on this as it is and I'm not
> remotely any authority on what benchmarks to use.
Maybe I can find the time to run a few tests, can anyone suggest me an "intersting" test?

 
> > > > I'm also testing the compressed cache (the 
> > > > patch you've discarded, and I got good performance!)
> > > 
> > > I'm thinking of eventually merging the latest version of this into 2.4.19
> > too
> > > since it can be enabled or disabled. Depends on the demand.
> > Just an hint ('cause I made some of the test you can see on the compressed
> > cache web page on sourceforge),
> > if you use that patch boot your box with the 
> > compressed=XXM in order to set the amount of the compressed cache. My box
> > runs fast and happy with 32MiB or 64MiB of compressed cache. My box has
> > 256MiB of Ram.
> 
> Ok thanks for the info. I believe the newer cc patch (not in my 2.4.18-ck4) is
> better anyway. I'm afraid the cc will be later in the piece assuming I can kill
> off the other bug I've created in the merge. I'd prefer to see a cc patch
> specifically for 2.4.19 as forward porting it to .19 and then to O(1) (and so
> on) are just too many steps. 
Fair enough.
I think that soon we'll see the cc path for the 2.4.19, Rodrigo?

Ciao,
          Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
