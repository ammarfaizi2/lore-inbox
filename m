Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161901AbWKJRpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161901AbWKJRpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 12:45:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161902AbWKJRpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 12:45:54 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:21125 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1161901AbWKJRpy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 12:45:54 -0500
Message-ID: <4554BAD0.7050409@s5r6.in-berlin.de>
Date: Fri, 10 Nov 2006 18:45:52 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Arjan van de Ven <arjan@infradead.org>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Jesper Juhl <jesper.juhl@gmail.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A proposal; making 2.6.20 a bugfix only version.
References: <9a8748490611081409x6b4cc4b4lc52b91c7b7b237a6@mail.gmail.com>	 <1163024531.3138.406.camel@laptopd505.fenrus.org>	 <20061108145150.80ceebf4.akpm@osdl.org>	 <1163064401.3138.472.camel@laptopd505.fenrus.org>	 <20061109013645.7bef848d.akpm@osdl.org>	 <1163065920.3138.486.camel@laptopd505.fenrus.org>	 <20061109111212.eee33367.akpm@osdl.org>	 <1163100115.3138.524.camel@laptopd505.fenrus.org>	 <20061109211121.GW4729@stusta.de>	 <1163107915.3138.541.camel@laptopd505.fenrus.org> <1163116618.8335.173.camel@localhost.localdomain>
In-Reply-To: <1163116618.8335.173.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
...
> Also the kernel.org bugzilla has a real flaw:
> 
> There is no way to get informed of new entries automatically and
> filtered by Category and Component.
...

There may be ways. I for one configured my bugzilla account to watch the
"user" drivers_ieee1394@kernel-bugs.osdl.org. That way I get notified of
bugs that are filed under category Drivers, component IEEE1394. Here is
a list of pseudo users or real users you could spy on:
http://bugzilla.kernel.org/describeallcomponents.cgi
-- 
Stefan Richter
-=====-=-==- =-== -=-=-
http://arcgraph.de/sr/
