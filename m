Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130473AbQKIMcF>; Thu, 9 Nov 2000 07:32:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130515AbQKIMb4>; Thu, 9 Nov 2000 07:31:56 -0500
Received: from 255.255.255.255.in-addr.de ([212.8.197.242]:51725 "HELO
	255.255.255.255.in-addr.de") by vger.kernel.org with SMTP
	id <S130473AbQKIMbm>; Thu, 9 Nov 2000 07:31:42 -0500
Date: Thu, 9 Nov 2000 13:31:36 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: Christoph Rohland <cr@sap.com>, Larry McVoy <lm@bitmover.com>,
        richardj_moore@uk.ibm.com, linux-kernel@vger.kernel.org
Subject: Re:  [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001109133136.B747@marowsky-bree.de>
In-Reply-To: <80256991.007632DE.00@d06mta06.portsmouth.uk.ibm.com> <3A09C725.6CFA0EE2@holly-springs.nc.us> <qwwn1f9lhdg.fsf@sap.com> <20001108235312.H22781@work.bitmover.com> <qwwzoj9k02h.fsf@sap.com> <3A0A968B.85A6770E@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <3A0A968B.85A6770E@holly-springs.nc.us>; from "Michael Rothwell" on 2000-11-09T07:20:27
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2000-11-09T07:20:27,
   Michael Rothwell <rothwell@holly-springs.nc.us> said:

> > I understand that the one size fits all approach has some limitations
> > if you want to run on PDAs up to big iron. But a framework to overload
> > core kernel functions with modules smells a lot of binary only, closed
> > source, vendor specific Linux on high end machines.
> 
> Since Linux is GPL, how would you stop this?

Christoph / SAP is in a rather good position to stop that being supported by
vendors...

> Same as before -- freedom and low cost. The primary advantae of Linux
> over other OSes is the GPL. 

And that is why that has to govern the kernel and its modules as far as
possible.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>
    Development HA

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
