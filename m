Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266277AbUBERSe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 12:18:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUBERSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 12:18:34 -0500
Received: from devil.servak.biz ([209.124.81.2]:51897 "EHLO devil.servak.biz")
	by vger.kernel.org with ESMTP id S266277AbUBERSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 12:18:32 -0500
Subject: Re: [2.6 patch] remove USB_SCANNER
From: Azog <slashmail@arnor.net>
To: Greg KH <greg@kroah.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Tom Rini <trini@kernel.crashing.org>,
       Andre Noll <noll@mathematik.tu-darmstadt.de>,
       Linux-Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040205011423.GA6092@kroah.com>
References: <20040126215036.GA6906@kroah.com>
	 <20040126215036.GA6906@kroah.com> <401A8A35.1020105@gmx.de>
	 <slrnc1l72v.9m.noll@localhost.mathematik.tu-darmstadt.de>
	 <20040130230633.GZ6577@stop.crashing.org> <20040202214326.GA574@kroah.com>
	 <20040205003136.GQ26093@fs.tum.de>  <20040205011423.GA6092@kroah.com>
Content-Type: text/plain
Message-Id: <1076001658.3225.101.camel@moria.arnor.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 05 Feb 2004 09:20:58 -0800
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - devil.servak.biz
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - arnor.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-04 at 17:14, Greg KH wrote:
> On Thu, Feb 05, 2004 at 01:31:36AM +0100, Adrian Bunk wrote:
[...]
> > If not, please apply the patch below plus do a
> >   rm drivers/usb/image/scanner.{c,h}
> 
> I've applied this patch, and removed the driver from the kernel.

(sigh) Just last night I had to reboot into 2.4 to use my new USB
scanner.

I tried for a while to get it working under 2.6.  I'm not exactly a
beginner at this stuff either.  

With 2.4 it took less than 30 seconds and worked perfectly, following
the SANE documentation instructions.  My user space is Fedora Core 1
with all available updates.

So, what are you all using / recommending for user space configuration
and control of a USB scanner under 2.6? 

http://www.codemonkey.org.uk/docs/post-halloween-2.6.txt doesn't say a
word about USB scanners, and I havn't seen the issue mentioned anywhere
else either.



