Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964805AbWIVR2A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964805AbWIVR2A (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 13:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964806AbWIVR2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 13:28:00 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S964805AbWIVR17
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 13:27:59 -0400
Received: from xenotime.net ([66.160.160.81]:20366 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932557AbWIVQfR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 12:35:17 -0400
Date: Fri, 22 Sep 2006 09:36:26 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michael Opdenacker <michael-lists@free-electrons.com>,
       linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.18] [TRIVIAL] Spelling fixes in
 Documentation/DocBook
Message-Id: <20060922093626.6c66ed89.rdunlap@xenotime.net>
In-Reply-To: <1158942873.24572.20.camel@localhost.localdomain>
References: <200609212318.07418.michael-lists@free-electrons.com>
	<1158942873.24572.20.camel@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.8 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
X-Face: &4L4\Oj/><0~x8W<MJeAB.(xC/cwW7Ay$UNDMI|/>]44\M(/wa:+,kH&IYtRqs\tQ8="B5=
 qPUwTvq4QPk_KQ^$5ya89f&[m.$<>cp-F(**n,^uIaN{YfG
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Sep 2006 17:34:33 +0100 Alan Cox wrote:

> >  	interrupt hardware and was therefore reimplemented with split
> > -	functionality for egde/level/simple/percpu interrupts. This is not
> > +	functionality for edge/level/simple/percpu interrupts. This is not
> 
> ACK - also per-cpu with hyphens ?

would be good.

> > -        requirement during issuing or excution any ATA/ATAPI command.
> > +        requirement during issuing or executing any ATA/ATAPI command.
> 
> NAK. Please check changes before submission

You want "execution" instead?  surely not "excution".

---
~~Randy
