Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSHTMJJ>; Tue, 20 Aug 2002 08:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316896AbSHTMJJ>; Tue, 20 Aug 2002 08:09:09 -0400
Received: from unthought.net ([212.97.129.24]:46516 "EHLO mail.unthought.net")
	by vger.kernel.org with ESMTP id <S316883AbSHTMJI>;
	Tue, 20 Aug 2002 08:09:08 -0400
Date: Tue, 20 Aug 2002 14:13:13 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: venom@sns.it
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: Does Solaris really scale this well?
Message-ID: <20020820121312.GA31156@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	venom@sns.it, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <15713.30718.950168.358907@wombat.chubb.wattle.id.au> <Pine.LNX.4.43.0208201209560.13141-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.43.0208201209560.13141-100000@cibs9.sns.it>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 12:13:44PM +0200, venom@sns.it wrote:
> 
> 80% is quite possible, I have similar results with a E10K domain of
> around 32 CPUs, with a 100mhz bus. Buf 80% is far from 94%...
> 

[shortening CC: to save electrons]

Let's end this thread shall we.

Anyone talking about scalability without talking about workload and
measurement is just spreading BS.

Anyone can get 100% (or even superlinear) scalability on a 1000
processor i486 with a 1 KHz bus, if the workload is right and
performance is measured "right".

The same person can get negative scalability on any THz (my-privates-
are-longer-and-fatter-than-yours)-bus machine out there, if the workload
is again chosen "correctly".

The thread could have gone on-topic, but it didn't   :)

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
