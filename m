Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271036AbTHQVFH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 17:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271043AbTHQVFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 17:05:07 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:43663 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S271036AbTHQVFC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 17:05:02 -0400
Subject: Re: Requested FAQ addition - Mandrake and partial-i686 platforms
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jan Rychter <jan@rychter.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030817202229.GB3543@mail.jlokier.co.uk>
References: <3F38FE5B.1030102@yahoo.com>
	 <1060705037.12532.49.camel@dhcp22.swansea.linux.org.uk>
	 <864r0lwmov.fsf@trasno.mitica> <m2r83kce2h.fsf@tnuctip.rychter.com>
	 <1061148472.23525.7.camel@dhcp23.swansea.linux.org.uk>
	 <20030817202229.GB3543@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061154277.23696.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 17 Aug 2003 22:04:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > The chips report cmov only if they have full cmov instructions, so
> > a look at /proc/cpuinfo will tell you.
> 
> So the register-only cmov on the Cyrix which you mentioned does not
> come with the cpuid cmov flag?

processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 7
model name      : VIA Samuel 2
stepping        : 3
cpu MHz         : 531.829
cache size      : 64 KB
physical id     : 0
siblings        : 1
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu de tsc msr cx8 mtrr pge mmx 3dnow
bogomips        : 1061.68


