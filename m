Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275918AbSIUOur>; Sat, 21 Sep 2002 10:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275919AbSIUOuq>; Sat, 21 Sep 2002 10:50:46 -0400
Received: from franka.aracnet.com ([216.99.193.44]:52706 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S275918AbSIUOuq>; Sat, 21 Sep 2002 10:50:46 -0400
Date: Sat, 21 Sep 2002 07:53:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.37 won't run X?
Message-ID: <591884585.1032594816@[10.10.2.3]>
In-Reply-To: <20020921121041.C20153@hh.idb.hist.no>
References: <20020921121041.C20153@hh.idb.hist.no>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> X won't start on 2.5.37, but works with 2.5.36
> The screen goes black as usual, but then nothing else happens.
> ssh'ing in from another machine shows XFree86 using 50% cpu,
> i.e. one of the two cpu's in this machine.

Looks like Linus fixed this already in his BK tree ... want
to grab that and see if it fixes your problem?

M.

