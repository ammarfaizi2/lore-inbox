Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262241AbSITK6q>; Fri, 20 Sep 2002 06:58:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262242AbSITK6p>; Fri, 20 Sep 2002 06:58:45 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:36738 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S262241AbSITK6p>; Fri, 20 Sep 2002 06:58:45 -0400
Date: Fri, 20 Sep 2002 13:04:01 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Andi Kleen <ak@suse.de>
cc: "David S. Miller" <davem@redhat.com>, johnstul@us.ibm.com,
       jamesclv@us.ibm.com, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org, anton.wilson@camotion.com
Subject: Re: do_gettimeofday vs. rdtsc in the scheduler
In-Reply-To: <20020918020535.A9784@wotan.suse.de>
Message-ID: <Pine.GSO.3.96.1020920130233.28010F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2002, Andi Kleen wrote:

> > It is internal or external to the processor?  Ie. can it be in the
> > southbridge or something?  If yes, then I still hold my point.
> 
> Local Apic is in the cpu.

 Except from when it's an i82489DX...  Rare but still.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

