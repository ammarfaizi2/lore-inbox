Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbTBTRQL>; Thu, 20 Feb 2003 12:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266135AbTBTRPl>; Thu, 20 Feb 2003 12:15:41 -0500
Received: from havoc.daloft.com ([64.213.145.173]:60565 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S265402AbTBTROk>;
	Thu, 20 Feb 2003 12:14:40 -0500
Date: Thu, 20 Feb 2003 12:24:39 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Ingo Molnar <mingo@elte.hu>,
       Dave Hansen <haveblue@us.ibm.com>,
       Zwane Mwaikambo <zwane@holomorphy.com>, Chris Wedgwood <cw@f00f.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: doublefault debugging (was Re: Linux v2.5.62 --- spontaneous reboots)
Message-ID: <20030220172439.GF9800@gtf.org>
References: <39710000.1045757490@[10.10.2.4]> <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302200847060.2493-100000@home.transmeta.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 08:54:55AM -0800, Linus Torvalds wrote:
> A sorted list of bad stack users (more than 256 bytes) in my default build
> follows. Anybody can create their own with something like
[...]

Yum.  Thanks for this list (and means to reproduce)...
