Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbTEFNa6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 09:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbTEFNa6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 09:30:58 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:5760
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263692AbTEFNaz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 09:30:55 -0400
Subject: Re: Binary firmware in the kernel - licensing issues.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Simon Kelley <simon@thekelleys.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3EB7B879.4040405@thekelleys.org.uk>
References: <3EB79ECE.4010709@thekelleys.org.uk>
	 <1052219735.28796.28.camel@dhcp22.swansea.linux.org.uk>
	 <3EB7B879.4040405@thekelleys.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052225092.1201.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 13:44:53 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 14:28, Simon Kelley wrote:
> My current plan is to make separate modules for each firmware image so 
> that people only need to compile in/load the one they need.
> 
> > 
> > (Debian as policy will rip the firmware out anyway regardless of what
> > Linus does btw)
> 
> Without exception? Time to hit debian-legal, methinks.

Unless the firmware itself includes full source code under the GPL yes.
There are rumblings in other places about doing the same because the
licensing issues are not clear otherwise.

> > The hotplug interface can be used to handle this.
> > 
> 
> Bah, more configuration. I want it to just _work_.

For the setup its a case of the existing hotplug scripts being updated
which isnt hard and for 2.5 this is currently being kicked around for
the general cases.

> So, back to the question: what license for a binary firmware blob is 
> GPL-compatible?

Try a lawyer, a good one with lots of experience in intellectual
property law in the US and EU. linux-kernel only thinks its qualified as
a lawyer 8)

Alan

