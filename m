Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268006AbTBWBHP>; Sat, 22 Feb 2003 20:07:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268007AbTBWBHP>; Sat, 22 Feb 2003 20:07:15 -0500
Received: from to-wiznet.redhat.com ([216.129.200.2]:1015 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S268006AbTBWBHO>; Sat, 22 Feb 2003 20:07:14 -0500
Date: Sat, 22 Feb 2003 20:17:24 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
Message-ID: <20030222201724.E5536@redhat.com>
References: <96700000.1045871294@w-hlinder> <20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay> <20030222024721.GA1489@work.bitmover.com> <14450000.1045888349@[10.10.2.4]> <20030222050514.GA3148@work.bitmover.com> <19870000.1045895965@[10.10.2.4]> <20030222083810.GA4170@gtf.org> <20030222221820.GI10401@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030222221820.GI10401@holomorphy.com>; from wli@holomorphy.com on Sat, Feb 22, 2003 at 02:18:20PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 02:18:20PM -0800, William Lee Irwin III wrote:
> I'm not sure what's so nice about x86-64; another opcode prefix
> controlled extension atop the festering pile of existing x86 crud

What's nice about x86-64 is that it runs existing 32 bit apps fast and 
doesn't suffer from the blisteringly small caches that were part of your 
rant.  Plus, x86-64 binaries are not horrifically bloated like ia64.  
Not to mention that the amount of reengineering in compilers like 
gcc required to get decent performance out of it is actually sane.

> sounds every bit as bad any other attempt to prolong x86. Some of
> the system device -level cleanups like the HPET look nice, though.

HPET is part of one of the PCYY specs and even available on 32 bit x86, 
there are just not that many bug free implements yet.  Since x86-64 made 
it part of the base platform and is testing it from launch, they actually 
have a chance at being debugged in the mass market versions.

		-ben
-- 
Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>
