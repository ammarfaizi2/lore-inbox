Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314503AbSEHQV0>; Wed, 8 May 2002 12:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314513AbSEHQV0>; Wed, 8 May 2002 12:21:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38645 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314503AbSEHQVZ>; Wed, 8 May 2002 12:21:25 -0400
Subject: Re: x86 question: Can a process have > 3GB memory?
From: Robert Love <rml@tech9.net>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Clifford White <ctwhite@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020508102934.Z31998@dualathlon.random>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 08 May 2002 09:21:38 -0700
Message-Id: <1020874898.2147.102.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-08 at 01:29, Andrea Arcangeli wrote:

> On Tue, May 07, 2002 at 04:08:55PM -0700, Robert Love wrote:
>
> > The attached patch (for which credit goes elsewhere - Ingo or Randy, I
> > think?) implements the full range of 1 to 3.5GB user space partitioning,
> 
> actually I'm the one who wrote the 3.5G config option both in 2.2 and
> recently I forward ported it to 2.4 due the number of requests I was
> getting.

Apologies - credit where credit is due.  It clearly came from -aa, what
with the 00_ naming prefix :)

Nice patch.

	Robert Love


