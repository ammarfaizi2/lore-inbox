Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316446AbSFUHg5>; Fri, 21 Jun 2002 03:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316456AbSFUHg4>; Fri, 21 Jun 2002 03:36:56 -0400
Received: from unthought.net ([212.97.129.24]:48855 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S316446AbSFUHg4>;
	Fri, 21 Jun 2002 03:36:56 -0400
Date: Fri, 21 Jun 2002 09:36:57 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: William Thompson <wt@electro-mechanical.com>, linux-kernel@vger.kernel.org
Subject: Re: partition md raid?
Message-ID: <20020621073657.GC19794@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Neil Brown <neilb@cse.unsw.edu.au>,
	William Thompson <wt@electro-mechanical.com>,
	linux-kernel@vger.kernel.org
References: <20020619103611.A7291@coredump.electro-mechanical.com> <15634.38076.959047.462763@notabene.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <15634.38076.959047.462763@notabene.cse.unsw.edu.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 21, 2002 at 12:51:40PM +1000, Neil Brown wrote:
> On Wednesday June 19, wt@electro-mechanical.com wrote:
> > Is this possible (w/o using lvm)
> 
> Yes, but you need a patch...
...

Any plans for getting this into the kernel Neil ?

I get quite a few questions from people who either do not understand
that you cannot partition md devices (and do various rather
involuntarily interesting setups because of that), or people who
understand the limitation but not the reason behind it.

Thinking about it, I don't know the reason   ;)

It's really a functionality that a lot of people feel naturally is
there, and I can't blame them.

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
