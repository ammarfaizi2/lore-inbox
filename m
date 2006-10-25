Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161380AbWJYUnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161380AbWJYUnj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 16:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161382AbWJYUnj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 16:43:39 -0400
Received: from xenotime.net ([66.160.160.81]:55170 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1161380AbWJYUni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 16:43:38 -0400
Date: Wed, 25 Oct 2006 13:45:16 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Marc Perkel <marc@perkel.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Frustrated with Linux, Asus, and nVidia, and AMD
Message-Id: <20061025134516.7645d92b.rdunlap@xenotime.net>
In-Reply-To: <453FB661.3020607@perkel.com>
References: <453EEE46.9040600@perkel.com>
	<p73vem8kyuv.fsf@verdi.suse.de>
	<453FB661.3020607@perkel.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2006 12:09:21 -0700 Marc Perkel wrote:

> 
> 
> Andi Kleen wrote:
> > Marc Perkel <marc@perkel.com> writes:
> >
> >   
> >> Ok - I had a bad day today struggling with hardware. Having said that
> >> I'm somewhat frustrated with the lack of progress of Linux getting it
> >> right with Asus, nVidia, and AMD processors right.
> >>
> >> I still have to run pci=nommconf to keep the server from locking
> >> up. That's with both 939 pin and AM2 motherboards.
> >>
> >> This bug remains unresolved:
> >>
> >> http://bugzilla.kernel.org/show_bug.cgi?id=6975
> >>
> >> So what's up with the no progress?
> >>     
> >
> > The bug report only references ancient kernels (2.6.15, 2.6.17) How do you know there is no
> > progress?
> >
> > -Andi
> >   
> As of the 2.6.18 released kernel I still had to modify the source code 
> to keep the kernel from locking up on boot. I haven't tried it with 
> 2.6.19rcx yet.

Have you posted your needed patches?
If so, please do it again.

---
~Randy
