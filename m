Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289066AbSAOLhs>; Tue, 15 Jan 2002 06:37:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289042AbSAOLhj>; Tue, 15 Jan 2002 06:37:39 -0500
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:40204 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S289043AbSAOLh2>; Tue, 15 Jan 2002 06:37:28 -0500
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery
	--the elegant solution)
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201151235110.28503-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0201151235110.28503-100000@netfinity.realnet.co.sz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 15 Jan 2002 05:35:05 -0600
Message-Id: <1011094507.19657.15.camel@zeus>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-01-15 at 04:40, Zwane Mwaikambo wrote:
> Normal users should _never_ have to use
> kernel.org trees.

Yikes! Sayings about never saying "never" aside... I should think the
goal is for everyone to be able to use kernel.org trees with reasonable
expectations. I'd like to see the day when distros can include a
pristine tree. I don't expect it, and the need for outside trees isn't
going away, but I'd like to see kernel.org be the canonical Linux for
more production systems, development starts, and non-i386 arch's.

With respect to Aunt Tillie, hardware discovery and kernel configuration
are separate issues. Can't the hardware probes be a separate package?
The autoconfigurator I think will be useful, but can't the configurator
just be dependent on outside packages like other functionality is
dependent on isdn4k-utils or iptables? 

Regards,
Reid "thinking this is getting offtopic" Hekman 
--
Current: reid.hekman@ndsu.nodak.edu
Permanent: hekman@acm.org 

