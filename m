Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133084AbREEUSy>; Sat, 5 May 2001 16:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135314AbREEUSe>; Sat, 5 May 2001 16:18:34 -0400
Received: from unthought.net ([212.97.129.24]:51175 "HELO mail.unthought.net")
	by vger.kernel.org with SMTP id <S133084AbREEUSK>;
	Sat, 5 May 2001 16:18:10 -0400
Date: Sat, 5 May 2001 22:18:08 +0200
From: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>
To: Michael Miller <michaelm@mjmm.org>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: curedump configuration additions
Message-ID: <20010505221808.C22425@unthought.net>
Mail-Followup-To: =?iso-8859-1?Q?Jakob_=D8stergaard?= <jakob@unthought.net>,
	Michael Miller <michaelm@mjmm.org>, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
In-Reply-To: <200105051955.f45JtAD02315@mjmm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2i
In-Reply-To: <200105051955.f45JtAD02315@mjmm.org>; from michaelm@mjmm.org on Sat, May 05, 2001 at 08:55:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 08:55:09PM +0100, Michael Miller wrote:
> Hi,
> 
> I have added some configuration options to the coredump abilities of the 
> kernel. Please can this patch be considered for addition to the kernel.

Hi, just wanted to recommend that this goes in, in one form or another  -  it
would help a lot around here.  Today we have to manually "fix" the kernel
source to get proper core.[executable] naming of core dumps.

I haven't looked at the patch though.  I don't know if it meets the standards,
but the functionaly it provides (or was meant to provide) would definitely be a
life-saver for me.   And it would put an end to the quarrels about core dump
naming   :)

Thanks,

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
