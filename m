Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129371AbQKIIoX>; Thu, 9 Nov 2000 03:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQKIIoP>; Thu, 9 Nov 2000 03:44:15 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:46002 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S129371AbQKIIoB>; Thu, 9 Nov 2000 03:44:01 -0500
From: Christoph Rohland <cr@sap.com>
To: Larry McVoy <lm@bitmover.com>
Cc: Michael Rothwell <rothwell@holly-springs.nc.us>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com>
	<3A09C725.6CFA0EE2@holly-springs.nc.us> <qwwn1f9lhdg.fsf@sap.com>
	<20001108235312.H22781@work.bitmover.com>
Organisation: SAP LinuxLab
Date: 09 Nov 2000 09:43:18 +0100
In-Reply-To: Larry McVoy's message of "Wed, 8 Nov 2000 23:53:12 -0800"
Message-ID: <qwwzoj9k02h.fsf@sap.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry,

On Wed, 8 Nov 2000, Larry McVoy wrote:
> On Thu, Nov 09, 2000 at 08:44:11AM +0100, Christoph Rohland wrote:
>> *Are you crazy?* =:-0 
>> 
>> Proposing proprietary kernel extensions to establish an enterprise
>> kernel? No thanks!
> 
> Actually, I think this idea is a good one.  I'm a big opponent of
> all the big iron feature bloat getting into the kernel, and if SGI
> et al want to go off and do their own thing, that's fine with me.
> As long as Linus continues in his current role, I doubt much of
> anything that the big iron boys do will really make it back into the
> generic kernel.  Linus is really smart about that stuff, are least
> it seems so to me; he seems to be well aware that 99.9999% of the
> hardware in the world isn't big iron and never will be, so something
> approximating 99% of the effort should be going towards the common
> platforms, not the uncommon ones.

If we would not allow binary only modules I would not have such a big
problem with that...

I understand that the one size fits all approach has some limitations
if you want to run on PDAs up to big iron. But a framework to overload
core kernel functions with modules smells a lot of binary only, closed
source, vendor specific Linux on high end machines. 

And then I don't see the value of Linux anymore.

Greetings
		Christoph
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
