Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318290AbSHUOCY>; Wed, 21 Aug 2002 10:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318292AbSHUOCX>; Wed, 21 Aug 2002 10:02:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:38894 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318290AbSHUOCW>; Wed, 21 Aug 2002 10:02:22 -0400
Subject: Re: IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Anton Altaparmakov <aia21@cantab.net>,
       Andre Hedrick <andre@linux-ide.org>, axboe@suse.de, bkz@linux-ide.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20020821152725.A4351@ucw.cz>
References: <Pine.SOL.3.96.1020817004411.25629B-100000@draco.cus.cam.ac.uk>
	<Pine.LNX.4.44.0208161706390.1674-100000@home.transmeta.com>
	<20020818131515.A15547@ucw.cz>
	<1029672964.15858.17.camel@irongate.swansea.linux.org.uk>
	<20020821121747.A3801@ucw.cz>
	<1029936007.26411.3.camel@irongate.swansea.linux.org.uk> 
	<20020821152725.A4351@ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 21 Aug 2002 15:06:18 +0100
Message-Id: <1029938778.26425.44.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-08-21 at 14:27, Vojtech Pavlik wrote:
> Even nicer? Easier to add new devices? Not having switch(deviceid)
> everywhere? Don't know. I believe they're better. In any case it's a lot
> of good work thrown away, yours or mine. :(

I don't mind a few deviceid switches. I don't find them annoying and
I'll take the stability of using known good code with the daft bits like
the rate filter while loop fixed over the unknowns of changing the code.

Once its in 2.4 and 2.5 and it works then I'm all ears, because at that
point we can actively quantify and test for regressions

