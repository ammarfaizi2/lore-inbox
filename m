Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270459AbRHHLlS>; Wed, 8 Aug 2001 07:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270458AbRHHLlK>; Wed, 8 Aug 2001 07:41:10 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:44306 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S270459AbRHHLk4>; Wed, 8 Aug 2001 07:40:56 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200108081140.NAA04248@green.mif.pg.gda.pl>
Subject: Re: How does "alias ethX drivername" in modules.conf work?
To: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 8 Aug 2001 13:40:52 +0200 (CEST)
Cc: rhw@MemAlpha.CX (Riley Williams), mra@pobox.com (Mark Atwood),
        linux-kernel@vger.kernel.org (Linux Kernel)
In-Reply-To: <m11ymmvn5o.fsf@frodo.biederman.org> from "Eric W. Biederman" at Aug 08, 2001 04:52:51 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Andrzej Krzysztofowicz <ankry@pg.gda.pl> writes:
> 
> > 1. NFS-root needs to have RARP/NFS servers on eth0.
> >    How can you deal with it if you have two boards supported by a single
> >    driver and, unfortunately, the one you need is detected as eth1 ?
> >    Assume that you cannot switch them as they use different media type...
> 
> Hmm.  Then my system that does DHCP/NFS root with 2.4.7 and comes up
> on eth2 is doesn't work?  Hmm it looks like it works to me.

Then the documentation I've read must be outdated.
Sorry.

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
