Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282146AbRKWN6S>; Fri, 23 Nov 2001 08:58:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282147AbRKWN6I>; Fri, 23 Nov 2001 08:58:08 -0500
Received: from ns.suse.de ([213.95.15.193]:2577 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S282146AbRKWN55>;
	Fri, 23 Nov 2001 08:57:57 -0500
Date: Fri, 23 Nov 2001 14:57:56 +0100
From: Andi Kleen <ak@suse.de>
To: Terje Eggestad <terje.eggestad@scali.no>
Cc: Andi Kleen <ak@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Q] was the SYSENTER/SYSCALL fast system calls completed or discared in the end??
Message-ID: <20011123145756.A5135@wotan.suse.de>
In-Reply-To: <1006184327.19902.2.camel@pc-16.office.scali.no.suse.lists.linux.kernel> <20011121225402.A175@elf.ucw.cz.suse.lists.linux.kernel> <1006440069.22598.4.camel@pc-16.office.scali.no.suse.lists.linux.kernel> <p73snb6x1wo.fsf@amdsim2.suse.de> <1006523642.25167.7.camel@pc-16.office.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <1006523642.25167.7.camel@pc-16.office.scali.no>; from terje.eggestad@scali.no on Fri, Nov 23, 2001 at 02:54:02PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 23, 2001 at 02:54:02PM +0100, Terje Eggestad wrote:
> Cool, 
> 
> do you happen top know where the patch is? On e that I can apply to
> stock 2.4.1x??

x86-64 is on ftp.x86-64.org

If you mean SYSENTER/SYSEXIT IIRC there were two indepdent patches for that
from Manfred Spraul and from Ingo Molnar. You have to ask them if they kept
any of them uptodate.


-Andi
