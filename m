Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265603AbTCCPZx>; Mon, 3 Mar 2003 10:25:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265687AbTCCPZt>; Mon, 3 Mar 2003 10:25:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:44443
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265603AbTCCPZq>; Mon, 3 Mar 2003 10:25:46 -0500
Subject: Re: Kernel Bug at spinlock.h ?!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: ChristopherHuhn <c.huhn@gsi.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-smp <linux-smp@vger.kernel.org>, support-gsi@credativ.de
In-Reply-To: <3E637137.3010105@GSI.de>
References: <3E630E3D.8060405@GSI.de>
	 <Pine.LNX.4.50.0303030348130.25240-100000@montezuma.mastecende.com>
	 <3E637137.3010105@GSI.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046709580.6509.9.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Mar 2003 16:39:41 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-03 at 15:13, ChristopherHuhn wrote:
> >Feb 24 14:45:34 lxb006 kernel: ICH3: BIOS setup was incomplete.
> >
> Does this mean we should upgrade to 2.5?

No the kernel cleaned that one up for you

