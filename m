Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbTIMUef (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 16:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262187AbTIMUef
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 16:34:35 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:59037 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262183AbTIMUee (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 16:34:34 -0400
Subject: Re: RFC: [2.6 patch] better i386 CPU selection
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dave Jones <davej@redhat.com>, Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030913185319.GC10047@gtf.org>
References: <20030913125103.GE27368@fs.tum.de>
	 <20030913161149.GA1750@redhat.com> <20030913182159.GA10047@gtf.org>
	 <20030913183758.GQ1191@redhat.com>  <20030913185319.GC10047@gtf.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063485121.9400.2.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sat, 13 Sep 2003 21:32:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-09-13 at 19:53, Jeff Garzik wrote:
> You're not understanding the model.  I understand your comment about
> using 386 kernels for install kernels.  If Adrian's patch is done
> right, _absolutely nothing should change_ in your described scenario.

Duh sorry - althoug Im unconvinced the ifdef explosion is worth it for
the tiny ones (the few hundred byte workarounds)

