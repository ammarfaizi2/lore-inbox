Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268533AbTBWTou>; Sun, 23 Feb 2003 14:44:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268535AbTBWTou>; Sun, 23 Feb 2003 14:44:50 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5956 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S268533AbTBWToo>; Sun, 23 Feb 2003 14:44:44 -0500
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
References: <96700000.1045871294@w-hlinder>
	<20030222001618.GA19700@work.bitmover.com> <306820000.1045874653@flay>
	<20030222024721.GA1489@work.bitmover.com>
	<14450000.1045888349@[10.10.2.4]>
	<20030222050514.GA3148@work.bitmover.com>
	<19870000.1045895965@[10.10.2.4]> <20030222083810.GA4170@gtf.org>
	<20030222221820.GI10401@holomorphy.com> <316510000.1045961436@flay>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 23 Feb 2003 12:54:43 -0700
In-Reply-To: <316510000.1045961436@flay>
Message-ID: <m1k7fqn56k.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> writes:

> > On Sat, Feb 22, 2003 at 03:38:10AM -0500, Jeff Garzik wrote:
> >> ia32 big iron.  sigh.  I think that's so unfortunately in a number
> >> of ways, but the main reason, of course, is that highmem is evil :)
> 
> One phrase ... "price:performance ratio". That's all it's about.
> The only thing that will kill 32-bit big iron is the availability of 
> cheap 64 bit chips. It's a free-market economy.
> 
> It's ugly to program, but it's cheap, and it works.

I guess ugly to program is in the eye of the beholder.  The big platforms
have always seemed much worse to me.  When every box is feels free to
change things in arbitrary ways for no good reason.  Or where OS and
other low-level software must know exactly which motherboard they are
running on to work properly.

Gratuitous incompatibilities are the ugliest thing I have ever seen.
Much less ugly then the warts a real platform accumulates because it
is designed to actually be used.

Eric
