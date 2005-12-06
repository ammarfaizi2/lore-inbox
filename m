Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030236AbVLFU3M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030236AbVLFU3M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 15:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVLFU3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 15:29:11 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27567 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030237AbVLFU3K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 15:29:10 -0500
Date: Tue, 6 Dec 2005 15:29:02 -0500
From: Dave Jones <davej@redhat.com>
To: =?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
Message-ID: <20051206202902.GC17108@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	=?utf-8?B?UGF3ZcWC?= Sikora <pluto@agmk.net>,
	linux-kernel@vger.kernel.org
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512061649.14470.pluto@agmk.net> <20051206190051.GA4232@irc.pl> <200512062011.55234.pluto@agmk.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200512062011.55234.pluto@agmk.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 06, 2005 at 08:11:55PM +0100, Paweł Sikora wrote:
 > Dnia wtorek, 6 grudnia 2005 20:00, Tomasz Torcz napisał:
 > > On Tue, Dec 06, 2005 at 04:49:14PM +0100, Paweł Sikora wrote:
 > > > Dnia wtorek, 6 grudnia 2005 16:30, Florian Weimer napisał:
 > > > > * Brian Gerst:
 > > > > > Once again I'd like to point out that user's purchase power means
 > > > > > jack when they only have two choices for video:  ATI and Nvidia.  You
 > > > > > can't walk into a computer store and find anything else (I don't
 > > > > > count integrated video on the motherboard as a solution, since only
 > > > > > Intel boards have it, sorry AMD users).  Even over the web it's hard
 > > > > > to find anything else.
 > > > >
 > > > > What about Matrox cards?  Are there open drivers for accelerated 2D
 > > > > operation?
 > > >
 > > > Open 2D is nothing new. The OpenGL is a major part.
 > > > Matrox and XGI (e.g. Volari V3 based cards) have openGL parts closed.
 > >
 > >  Interesting remark, but false.
 > 
 > I investigated only mtx driver from theirs website.

Indeed, anything newer than a G550 is binary only as far as 3D is concerned.
Sad, as Matrox used to be a really good recommendation for an
opensource friendly graphic card vendor.

It's not as if their newer cards are even that fast, so my only
guess is that they've gone the binary blob route purely for
paranoia reasons.

That said, they had a binary blob for some of the special
features of their cards for a long time, but most users would
never need it.

		Dave

