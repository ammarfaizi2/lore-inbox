Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313144AbSC1Mmc>; Thu, 28 Mar 2002 07:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313145AbSC1MmX>; Thu, 28 Mar 2002 07:42:23 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:26285 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313144AbSC1MmK>; Thu, 28 Mar 2002 07:42:10 -0500
Date: Thu, 28 Mar 2002 13:42:06 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>, Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <E16qHy4-0005l7-00@the-village.bc.nu>
Message-ID: <Pine.GSO.3.96.1020328133623.11187A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Alan Cox wrote:

> >  How can't it be critical?  Your system is overheating.  It is about to
> > fail -- depending on the configuration, it'll either crash or be shut down
> 
> Neither. It will drop to a much lower clock speed. You can set it to overheat
> and blow up but thats a mostly undocumented mtrr 8) The default behaviour is
> to throttle back hard

 Depending on the reason of an overheat condition this may circumvent the
problem or not.  As I already stated you may have fire in the room (and
not all computer rooms seem to have automatic extinguishing systems). 
Hardware failures are not to be treated lightly. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

