Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263899AbSJOJaD>; Tue, 15 Oct 2002 05:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSJOJaD>; Tue, 15 Oct 2002 05:30:03 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:60413 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S263899AbSJOJaC>; Tue, 15 Oct 2002 05:30:02 -0400
X-Mailer: exmh version 2.5 13/07/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20021014130441.GA528@suse.de> 
References: <20021014130441.GA528@suse.de>  <20021013234308.P23142@flint.arm.linux.org.uk> <Pine.LNX.4.33L2.0210131615480.22520-100000@dragon.pdx.osdl.net> <20021013215726.P16698@osinvestor.com> <20021014101209.A18123@medelec.uia.ac.be> <20021014122239.GA29240@suse.de> <20021014144158.A19209@medelec.uia.ac.be> 
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Wim Van Sebroeck <wim@iguana.be>, Rob Radez <rob@osinvestor.com>,
       "Randy.Dunlap" <rddunlap@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org
Subject: Re: Watchdog drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 15 Oct 2002 10:35:38 +0100
Message-ID: <15236.1034674538@passion.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


davej@codemonkey.org.uk said:
>  They remain character devices, so drivers/char/watchdog/  gets my
> vote. Any nay-sayers ? 

By that logic, we should have only drivers/{net,char,block}.

--
dwmw2


