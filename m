Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262838AbSJLJQ2>; Sat, 12 Oct 2002 05:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262847AbSJLJQ2>; Sat, 12 Oct 2002 05:16:28 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:5650 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S262838AbSJLJQ1>;
	Sat, 12 Oct 2002 05:16:27 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200210120922.g9C9MB219606@saturn.cs.uml.edu>
Subject: Re: [ANNOUNCE] procps 3.0.1
To: m.c.p@wolk-project.de (Marc-Christian Petersen)
Date: Sat, 12 Oct 2002 05:22:11 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, acahalan@cs.uml.edu (Albert D. Cahalan)
In-Reply-To: <200210110920.12208.m.c.p@wolk-project.de> from "Marc-Christian Petersen" at Oct 11, 2002 09:20:49 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc-Christian Petersen writes:

>> top:    windows, color, sort any field, 2.5.xx kernel support
>> sysctl: supports the VLAN interfaces
>> ps:     runs 2x faster than procps-2.x.x did
>> vmstat: 2.5.xx kernel support
>
> Say, can you please, if you want to support kernel 2.5.xx also,
> do it right?

You're running a 2.2.xx or 2.0.xx non-SMP kernel, aren't you?
No problem anymore, get the 3.0.2 release.

The top program is also back to looking normal by default
and doing a %CPU sort by default. I fixed "make install" and
some more vmstat troubles too. Enjoy.

http://procps.sf.net/

