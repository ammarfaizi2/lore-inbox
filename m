Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132478AbQLNVGf>; Thu, 14 Dec 2000 16:06:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132636AbQLNVGZ>; Thu, 14 Dec 2000 16:06:25 -0500
Received: from smtp01.mrf.mail.rcn.net ([207.172.4.60]:4035 "EHLO
	smtp01.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id <S132478AbQLNVGR>; Thu, 14 Dec 2000 16:06:17 -0500
Date: Thu, 14 Dec 2000 15:35:48 -0500 (EST)
From: "Mohammad A. Haque" <mhaque@haque.net>
To: Ion Badulescu <ionut@cs.columbia.edu>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ip_defrag is broken (was: Re: test12 lockups -- need feedback)
In-Reply-To: <Pine.LNX.4.30.0012141204210.27848-100000@age.cs.columbia.edu>
Message-ID: <Pine.LNX.4.30.0012141535310.12994-100000@viper.haque.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll be trying in a few hours.

On Thu, 14 Dec 2000, Ion Badulescu wrote:

> On Thu, 14 Dec 2000, David S. Miller wrote:
>
> > If you turn off netfilter, ip_conntrack, etc. does the OOPS still
> > occur?
>
> I'm afraid I won't be able to answer this question, since I'm leaving for
> a 3-week vacation in about 50 minutes and I need my firewall functional
> until then. :-) Maybe other people who have seen this problem can
> experiment further.
>
> If I get a few moments, I'll do a quick test before leaving and will let
> you know. The chance of that happening is extremely slim, though.
>
> Thanks,
> Ion
>
>

-- 

=====================================================================
Mohammad A. Haque                              http://www.haque.net/
                                               mhaque@haque.net

  "Alcohol and calculus don't mix.             Project Lead
   Don't drink and derive." --Unknown          http://wm.themes.org/
                                               batmanppc@themes.org
=====================================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
