Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265253AbSKFBBY>; Tue, 5 Nov 2002 20:01:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265256AbSKFBBY>; Tue, 5 Nov 2002 20:01:24 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44041 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S265253AbSKFBBX>; Tue, 5 Nov 2002 20:01:23 -0500
Date: Tue, 5 Nov 2002 20:07:18 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Dax Kelson <dax@gurulabs.com>
cc: "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com, davej@suse.de
Subject: Re: Filesystem Capabilities in 2.6?
In-Reply-To: <1036262156.31699.78.camel@thud>
Message-ID: <Pine.LNX.3.96.1021105200417.20567B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 Nov 2002, Dax Kelson wrote:

> Most sysadmin can't 'deal with X', where X is:
> 
> - Configure kerberos
> - Use setfactl
> - ext2/3 attributes

Most don't need to. The lst time I did Kerberos I believe it was on a
Sun-3. To special use and security issues you might add custom PAM. The
other stuff on your list a good admin should be able to do, although more
sites are using a "vendor kernel only" policy.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

