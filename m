Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262832AbUBZTqm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 14:46:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262943AbUBZTqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 14:46:42 -0500
Received: from chaos.analogic.com ([204.178.40.224]:14209 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262832AbUBZTn1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 14:43:27 -0500
Date: Thu, 26 Feb 2004 14:46:00 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Timothy Miller <miller@techsource.com>
cc: Chris Wedgwood <cw@f00f.org>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       richard.brunner@amd.com, linux-kernel@vger.kernel.org
Subject: Re: Intel vs AMD64
In-Reply-To: <403E481E.7060609@techsource.com>
Message-ID: <Pine.LNX.4.53.0402261442420.4239@chaos>
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com>
 <20040226133959.GA19254@dingdong.cryptoapps.com> <Pine.LNX.4.53.0402260913300.32691@chaos>
 <403E481E.7060609@techsource.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Feb 2004, Timothy Miller wrote:

>
>
> Richard B. Johnson wrote:
>
> > Whether or not the CPU traps this invalid instruction is moot. No
> > compiler would emit junk like this and anybody horsing around with
> > an assembler deserves whatever they get, although you shouldn't
> > be able to smoke the CPU on a multi-user multitasking system because
> > it can be used as a DOS attack.
>
>
> If this is junk that's invalid, why was it mentioned in the first place?
>

Because there are hobbiest that look for undocumented op-codes, see
	http://www.x86.org

They find some interesting things and then they wonder if what
they've found will work with other vendor's CPUs.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


