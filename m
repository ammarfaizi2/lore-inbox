Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130346AbRCCFsZ>; Sat, 3 Mar 2001 00:48:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130347AbRCCFsP>; Sat, 3 Mar 2001 00:48:15 -0500
Received: from host11.optimumdata.dsl.radiks.net ([207.232.85.172]:63247 "EHLO
	subby.optimumdata.com") by vger.kernel.org with ESMTP
	id <S130346AbRCCFsA>; Sat, 3 Mar 2001 00:48:00 -0500
Date: Fri, 2 Mar 2001 23:46:52 -0600 (CST)
From: <phil@optimumdata.com>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: Linux Advanced Routing and Trafic Control <lartc@mailman.ds9a.nl>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [LARTC] 1 adsl + 1 sdsl + masq + simultaneous incomming
 routes]
In-Reply-To: <3AA06720.77D94BFE@matchmail.com>
Message-ID: <Pine.LNX.4.32.0103022338210.473-100000@subby.optimumdata.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2001, Mike Fedyk wrote:

> There has to be a better way.

It's the one I use; it works and works well.

Asking someone who deals with "network appliance" routers (ie Cisco) might
lead to some ideas.  But the Cisco folks I asked recommended the solution
I told you about.  You might have better luck asking someone else.

> I'm forwarding this to LKML.  Maybe they have a better idea...

netdev@oss.sgi.com (or something like that) is actually a better place

> I know the kernel keeps a route cache, is there something like a reverse MASQ
> feature somewhere.  Storing which incoming route + port number and keeping a
> dynamic list...

-- 
-----------------------------------------------------------------------
Phil Brutsche                                      phil@optimumdata.com

