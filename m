Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292493AbSBPT0f>; Sat, 16 Feb 2002 14:26:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292494AbSBPT00>; Sat, 16 Feb 2002 14:26:26 -0500
Received: from flrtn-4-m1-42.vnnyca.adelphia.net ([24.55.69.42]:11661 "EHLO
	jyro.mirai.cx") by vger.kernel.org with ESMTP id <S292493AbSBPT0V>;
	Sat, 16 Feb 2002 14:26:21 -0500
Date: Sat, 16 Feb 2002 11:25:49 -0800 (PST)
From: jjs@mirai.cx
To: Jason Czerak <Jason-Czerak@Jasnik.net>
cc: john slee <indigoid@higherplane.net>, J Sloan <joe@tmsusa.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: tux officially in kernel?
In-Reply-To: <1013885982.1680.2.camel@neworder>
Message-ID: <Pine.LNX.4.44.0202161118510.21847-100000@jyro.mirai.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Feb 2002, Jason Czerak wrote:

> If I"m not mistaken, Tux needs SSL and V-domains support.

You are partly mistaken - tux does virtual domains like a champ.
Mass virtual hosting is easy and effective. Tux does need to pass
SSL requests off to a helper server though.

>  then I can use
> it instead of Apache with mod_proxy (static) --> Apache mod_perl
> (dynamic content) dual apache setup.  

I'd love to see mod_perl for tux - did I miss something?

I'd be just as happy about php, and there is what looks like the beginning
of tux support in php. If tux could load and run php modules, it would 
open a lot of doors very quickly. (i.e. there are a lot more php 
programmers out there than are in the tiny, rather elite group of those 
who understand and can use the tux dynamic content api.)

> Once this happens. My little
> PII-350 should surly keep up with, if not be faster then that Dual 733
> NT box for static content :) 

Indeed.

Joe

