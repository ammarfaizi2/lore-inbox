Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268038AbTBWFMY>; Sun, 23 Feb 2003 00:12:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268040AbTBWFMY>; Sun, 23 Feb 2003 00:12:24 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:48343 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268038AbTBWFMX>; Sun, 23 Feb 2003 00:12:23 -0500
To: Benjamin LaHaise <bcrl@redhat.com>
cc: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: Minutes from Feb 21 LSE Call 
In-reply-to: Your message of Sat, 22 Feb 2003 20:17:24 EST.
             <20030222201724.E5536@redhat.com> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21597.1045977697.1@us.ibm.com>
Date: Sat, 22 Feb 2003 21:21:37 -0800
Message-Id: <E18moa2-0005cP-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2003 20:17:24 EST, Benjamin LaHaise wrote:
> On Sat, Feb 22, 2003 at 02:18:20PM -0800, William Lee Irwin III wrote:
> > I'm not sure what's so nice about x86-64; another opcode prefix
> > controlled extension atop the festering pile of existing x86 crud
> 
> What's nice about x86-64 is that it runs existing 32 bit apps fast and 
> doesn't suffer from the blisteringly small caches that were part of your 
> rant.  Plus, x86-64 binaries are not horrifically bloated like ia64.  
> Not to mention that the amount of reengineering in compilers like 
> gcc required to get decent performance out of it is actually sane.
 
Four or five years ago the claim was that IA64 would solve all the large
memory problems.  Commercial viability and substantial market presence
is still lacking.  x86-64 has the same uphill battle.  It has a better
architecture for highmem and potentially better architecture for large
systems in general (compared to IA32, not substantially better than, say,
IA64 or PPC64).  It also has at least one manufacturer looking at high
end systems.  But until those systems have some recognized market share,
the boys with the big pockets aren't likely to make the ubiquitous.
The whole thing about expenses to design and develop combined with the
ROI model have more influence on their deployment than the fact that it
is technically a useful architecture.

gerrit
