Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317538AbSFLMja>; Wed, 12 Jun 2002 08:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSFLMj3>; Wed, 12 Jun 2002 08:39:29 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:61852 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S317538AbSFLMj1>;
	Wed, 12 Jun 2002 08:39:27 -0400
Date: Wed, 12 Jun 2002 08:33:26 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Lincoln Dale <ltd@cisco.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
        "David S. Miller" <davem@redhat.com>,
        Ben Greear <greearb@candelatech.com>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets 
In-Reply-To: <5.1.0.14.2.20020612221925.0283fb18@mira-sjcm-3.cisco.com>
Message-ID: <Pine.GSO.4.30.0206120829240.799-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 12 Jun 2002, Lincoln Dale wrote:

> At 08:11 AM 12/06/2002 -0400, Horst von Brand wrote:
> >General dislike for adding features of _extremely_ limited (debugging!) use?
>
> i would imagine that every installation of Squid on linux is interested in
> having _realistic transaction logs_ of exactly how much data was received
> and transmitted on a TCP connection.
>
> i know of many many folk who use transaction logs from HTTP caches for
> volume-based billing.
> right now, those bills are anywhere between 10% to 25% incorrect.
>
> you call that "extremely limited"?
>

Surely, you must have better ways to do accounting than this -- otherwise
you deserve to loose money.

>
> of course, i am doing exactly what Dave said to do -- maintaining my own
> out-of-kernel patch -- but its a pain, i'm sure it will soon conflict with
> stuff and is a damn shame - it isn't much code, but Dave seems pretty
> steadfast that he isn't interested.
>

You havent proven why its needed. And from the looks of it you dont even
need it. If 3 people need it, then i would like to ask we add lawn mower
support that my relatives have been asking for the last 5 years.

cheers,
jamal

