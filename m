Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280943AbRKLTHO>; Mon, 12 Nov 2001 14:07:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280940AbRKLTHF>; Mon, 12 Nov 2001 14:07:05 -0500
Received: from air-1.osdl.org ([65.201.151.5]:58752 "EHLO
	wookie-laptop.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S280933AbRKLTGv>; Mon, 12 Nov 2001 14:06:51 -0500
Subject: Re: Regression testing of 2.4.x before release?
From: "Timothy D. Witham" <wookie@osdl.org>
To: Dan Kegel <dank@kegel.com>
Cc: Luigi Genoni <kernel@Expansa.sns.it>, Mike Galbraith <mikeg@wen-online.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stp@osdl.org
In-Reply-To: <3BEF6B1B.1E077ED9@kegel.com>
In-Reply-To: <Pine.LNX.4.33.0111041955290.30596-100000@Expansa.sns.it> 
	<3BE5F0B5.52274D07@kegel.com>
	<1004978377.1226.22.camel@wookie-laptop.pdx.osdl.net> 
	<3BEF6B1B.1E077ED9@kegel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.07.16.47 (Preview Release)
Date: 12 Nov 2001 11:07:34 -0800
Message-Id: <1005592054.16715.35.camel@wookie-laptop.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2001-11-11 at 22:24, Dan Kegel wrote:
> "Timothy D. Witham" wrote:

  Snip

> 
> At some point it might be nice to also use the STP to help
> speed gcc 3 development, too.  (I personally am really
> looking forward to the day when I can use the same compiler
> for both c++ and kernel.)
> 

  Strange, I was just talking to somebody about compiler 
performance and regression issues and what sort of automation
could be done to do that sort of testing.  

  Since the STP is really a framework and just about any piece
of software and testing environment could be worked into it.

 So I guess you could have two pieces.  One that just ran a bunch
of compile and user level tests and then one that went in and
checked out the compiler on a kernel tree and then ran the
same performance tests that had been run using the "standard"
compiler.  

  Are you stepping forward to integrate this into STP? :-)

> - Dan
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

