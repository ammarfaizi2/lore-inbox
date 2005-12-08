Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932234AbVLHSos@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932234AbVLHSos (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 13:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVLHSos
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 13:44:48 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:15301 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932234AbVLHSor convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 13:44:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oFHElAXFn5TPy/u/jyZfRe7cOi07R3UjplwPdqI3OGlarEaNg1h8brJr96iRrgXTBWtX1lZKL4FJb7uv7R04LW/bX43aDiBHAojAF+EEi24y8e/iyrrvQQe6CF4vtClOdFfIFApM69gBXABFfUxhRrW62yFZyBdPWmHezTZ0CMc=
Message-ID: <161717d50512081044o73046587nd023f7e1648ad585@mail.gmail.com>
Date: Thu, 8 Dec 2005 13:44:46 -0500
From: Dave Neuer <mr.fred.smoothie@pobox.com>
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Linux in a binary world... a doomsday scenario
Cc: Andrea Arcangeli <andrea@cpushare.com>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1133986742.2869.65.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>
	 <20051205121851.GC2838@holomorphy.com>
	 <20051206011844.GO28539@opteron.random>
	 <1133857767.2858.25.camel@laptopd505.fenrus.org>
	 <Pine.LNX.4.63.0512071337560.17172@cuia.boston.redhat.com>
	 <Pine.LNX.4.58.0512071041420.17648@shark.he.net>
	 <1133981708.2869.54.camel@laptopd505.fenrus.org>
	 <20051207201612.GV28539@opteron.random>
	 <1133986742.2869.65.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/7/05, Arjan van de Ven <arjan@infradead.org> wrote:
>
> > A moinmoin wiki.kernel.org should work fine and it takes 10 minutes to
> > set it up. Let's use the community to build this list. Perhaps
> > wiki.kernel.org could also be used to document some kernel stuff later
> > on.
>
> the problem with this is that with wiki's you get a sliding scope wrt
> criteria; I mean, many people will say nvidia graphics work great with
> linux... and the wiki will represent that ;(
>

Well, if the USB developers are already keeping a list of "known
good/known bad" devices, and the IEEE 1394 people are maintaining such
a list, and the ALSA people are maintaining a list, wouldn't it make
sense to just have some sort of agregation method to present a
centralized front end to the information? A distributed hardware
matrix as it were?

Seems wise, in order to avoid the problem that Arjan mentioned, to
have developers closest to the drivers to be the primary maintainers
of the info. Users are obviously going to be an important source of
information, but having random users editing a wiki page with "works
great for me," "doesn't work at all for me"-style comments appears
less helpful than a matrix maintained w/ input from users (where input
from users is primarily though the bug reporting process or something
else a little more disciplined than unqualified affirmative or
negative blurbs).

Dave
