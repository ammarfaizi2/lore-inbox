Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130447AbQKIMbE>; Thu, 9 Nov 2000 07:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130473AbQKIMap>; Thu, 9 Nov 2000 07:30:45 -0500
Received: from 255.255.255.255.in-addr.de ([212.8.197.242]:49677 "HELO
	255.255.255.255.in-addr.de") by vger.kernel.org with SMTP
	id <S130447AbQKIMaf>; Thu, 9 Nov 2000 07:30:35 -0500
Date: Thu, 9 Nov 2000 13:30:23 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: Christoph Rohland <cr@sap.com>, richardj_moore@uk.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re:  [ANNOUNCE] Generalised Kernel Hooks Interface (GKHI)
Message-ID: <20001109133023.A747@marowsky-bree.de>
In-Reply-To: <80256992.002FE358.00@d06mta06.portsmouth.uk.ibm.com> <qwwvgtxjslr.fsf@sap.com> <3A0A97D0.36C5913B@holly-springs.nc.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <3A0A97D0.36C5913B@holly-springs.nc.us>; from "Michael Rothwell" on 2000-11-09T07:25:52
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2000-11-09T07:25:52,
   Michael Rothwell <rothwell@holly-springs.nc.us> said:

> Why? I think the IBM GKHI code would be of tremendous value. It would
> make the kernel much more flexible, and for users, much more friendly.
> No more patch-and-recompile to add a filesystem or whatever. There's no
> reason to hamstring their efforts because of the possibility of binary
> modules. The GPL allows that, right? So any developer of binary-only
> extensions using the GKHI would not be breaking the license agreement, I
> don't think. There's lots of binary modules right now -- VMWare, Aureal
> sound card drivers, etc.

And we already refuse to support those kernels - your point being?

Making this "commonplace" is a nightmare. Go away with that.

> I understand and agree with your desire for full source for everything,
> but I disagree that we should artificially limit people's ability to use
> Linux to solve their problems.

I want their solving of their problems not to create problems for me though.

Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>
    Development HA

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
