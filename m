Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267716AbTAMBQr>; Sun, 12 Jan 2003 20:16:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267724AbTAMBQr>; Sun, 12 Jan 2003 20:16:47 -0500
Received: from mta7.srv.hcvlny.cv.net ([167.206.5.22]:21432 "EHLO
	mta7.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S267716AbTAMBQq>; Sun, 12 Jan 2003 20:16:46 -0500
Date: Sun, 12 Jan 2003 20:21:50 -0500
From: Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
In-reply-to: <1850.4.64.197.173.1042420003.squirrel@www.osdl.org>
To: Randy Dunlap <rddunlap@osdl.org>
Cc: akropel1@rochester.rr.com, matti.aarnio@zmailer.org,
       linux-kernel@vger.kernel.org
Reply-to: robw@optonline.net
Message-id: <1042420910.3162.277.camel@RobsPC.RobertWilkens.com>
Organization: Robert Wilkens
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com>
 <1042400094.1208.26.camel@RobsPC.RobertWilkens.com>
 <20030112211530.GP27709@mea-ext.zmailer.org>
 <1042406849.3162.121.camel@RobsPC.RobertWilkens.com>
 <20030112215949.GA2392@www.kroptech.com>
 <1042410059.1208.150.camel@RobsPC.RobertWilkens.com>
 <1850.4.64.197.173.1042420003.squirrel@www.osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-01-12 at 20:06, Randy Dunlap wrote:
> So you choose to agree with your lessons that goto is bad, but
> ignore the other lesson that functions shouldn't have multiple
> return paths?  Or didn't have that lesson?
> ~Randy

I didn't have a lesson about multiple return paths.. I actually before
posting checked out the coding style document..

:/usr/src/linux-2.5.56/Documentation# grep -i return CodingStyle

Returned nothing..  There was no mention of using return in the middle
or end of a function in the coding style document, though perhaps there
should be.

-Rob

