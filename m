Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314101AbSFLGdF>; Wed, 12 Jun 2002 02:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317646AbSFLGdE>; Wed, 12 Jun 2002 02:33:04 -0400
Received: from netcore.fi ([193.94.160.1]:50188 "EHLO netcore.fi")
	by vger.kernel.org with ESMTP id <S314101AbSFLGdC>;
	Wed, 12 Jun 2002 02:33:02 -0400
Date: Wed, 12 Jun 2002 09:32:58 +0300 (EEST)
From: Pekka Savola <pekkas@netcore.fi>
To: Ben Greear <greearb@candelatech.com>
cc: Mark Mielke <mark@mark.mielke.cc>, <linux-kernel@vger.kernel.org>,
        <netdev@oss.sgi.com>
Subject: Re: RFC: per-socket statistics on received/dropped packets
In-Reply-To: <3D06E9A0.5060801@candelatech.com>
Message-ID: <Pine.LNX.4.44.0206120930160.29780-100000@netcore.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jun 2002, Ben Greear wrote:
> If they are useful to some people, and have zero performance affect on others
> (due to being a configurable kernel feature), then what is your
> complaint?

3) Added features and complexity makes it more difficult to maintain the 
kernel (you could say this is a variant of 1)

4) Patches that have only a little debugging/etc. value are probably 
useful, but mainly for a specific set of people, and this would seem to be 
best handled by external patches.
 
> 1)  General increase in #ifdef'd code.  This actually seems like
>     a pretty good argument, but I haven't seen anyone mention it
>     specifically.

Always implied from maintenance point-of-view.
 
-- 
Pekka Savola                 "Tell me of difficulties surmounted,
Netcore Oy                   not those you stumble over and fall"
Systems. Networks. Security.  -- Robert Jordan: A Crown of Swords


