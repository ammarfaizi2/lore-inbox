Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWJMKxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWJMKxQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 06:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWJMKxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 06:53:16 -0400
Received: from poczta.o2.pl ([193.17.41.142]:59558 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1751063AbWJMKxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 06:53:15 -0400
Date: Fri, 13 Oct 2006 12:58:07 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: David Johnson <dj@david-web.co.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Hardware bug or kernel bug?
Message-ID: <20061013105807.GB1690@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	David Johnson <dj@david-web.co.uk>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20061013085605.GA1690@ff.dom.local> <200610131020.48232.dj@david-web.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610131020.48232.dj@david-web.co.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 10:20:48AM +0100, David Johnson wrote:
> On Friday 13 October 2006 09:56, Jarek Poplawski wrote:
> >
> > I'd try with this:
> > - minimal workable config with a lot of debugging turned on (e.g. no:
> > smp, floppy, parport, mouse, ipv6, video, clock modulation, apm, acpi
> > buttons, thermal etc. - only base acpi or no if possible),
> > - 2.4 kernel,
> > - other distro e.g. live-cd knoppix,
> > - other transfer method like ftp (all superfluous services turned off).
> >
> 
> I'll give that a go and I guess I should also see whether I can reproduce it 
> under Windows too...

Sure! After all we shouldn't be system nazis and let others do
some secondary jobs...  

Regards,

Jarek P.

PS: I hope you tested it also under internal stress (heavy
copying plus computing). 
