Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268108AbUJOQRi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268108AbUJOQRi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Oct 2004 12:17:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268122AbUJOQRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Oct 2004 12:17:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:58079 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268108AbUJOQRd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Oct 2004 12:17:33 -0400
Subject: Re: Fw: signed kernel modules?
From: Josh Boyer <jdub@us.ibm.com>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org, root@chaos.analogic.com,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>
In-Reply-To: <200410151153.08527.gene.heskett@verizon.net>
References: <27277.1097702318@redhat.com>
	 <Pine.LNX.4.61.0410150723180.8573@chaos.analogic.com>
	 <1097843492.29988.6.camel@weaponx.rchland.ibm.com>
	 <200410151153.08527.gene.heskett@verizon.net>
Content-Type: text/plain
Message-Id: <1097857049.29988.29.camel@weaponx.rchland.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 15 Oct 2004 11:17:29 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-15 at 10:53, Gene Heskett wrote:
> >
> >cd linux-2.6;
> >patch -R -p1 < ../<modsign patch name>
> >
> >josh
> >
> Yes, but what happens if it gets into the tarballs from kernel.org.
> 
> Stop this nonsense Linus, now.

While my original post was more of a symbolic "I think you're being a
bit over-dramatic" response, it's still valid once it's in a tarball
too.  A tarball is just source that has the patch applied...

I personally don't see anything wrong with concept of signed modules. 
Make it a config option and call it good.  I'd probably never run with
signed modules with a kernel I built myself, but that's my choice. 
Others can choose differently.

Let's separate the technical details from the opinions about whether
such a feature will end the free world as we know it or not.  (Which it
won't).

josh

