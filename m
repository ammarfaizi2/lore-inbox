Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261319AbSJCXFm>; Thu, 3 Oct 2002 19:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261453AbSJCXFM>; Thu, 3 Oct 2002 19:05:12 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:53143 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261452AbSJCXFK>;
	Thu, 3 Oct 2002 19:05:10 -0400
Date: Thu, 3 Oct 2002 19:10:28 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: John Levon <levon@movementarian.org>
cc: kernel <linux-kernel@vger.kernel.org>, rml@tech9.net,
       davej@codemonkey.org.uk, torvalds@transmeta.com
Subject: Re: export of sys_call_table
In-Reply-To: <20021003225842.GA79989@compsoc.man.ac.uk>
Message-ID: <Pine.GSO.4.21.0210031903480.15787-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Oct 2002, John Levon wrote:

> Sort of. They've broken IA64 oprofile, and they seem not to care.

More or less off-topic, but could the persons who'd invented that
name stand up and tell what the hell were they thinking about?

Al, who can't help misreading that name 10 times out of 10.  The worst
thing being, coprofile sounds like a very apt description of way too many
files in drivers/*...

