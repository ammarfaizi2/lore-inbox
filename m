Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261781AbTIPEa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Sep 2003 00:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261782AbTIPEa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Sep 2003 00:30:28 -0400
Received: from modemcable137.219-201-24.mtl.mc.videotron.ca ([24.201.219.137]:6786
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261781AbTIPEa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Sep 2003 00:30:27 -0400
Date: Tue, 16 Sep 2003 00:30:31 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Kevin Breit <mrproper@ximian.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Need fixing of a rebooting system
In-Reply-To: <1063650478.1516.0.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.53.0309151440540.5140@montezuma.fsmlabs.com>
References: <1063496544.3164.2.camel@localhost.localdomain> 
 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>  <3F6450D7.7020906@ximian.com>
  <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com> 
 <1063561687.10874.0.camel@localhost.localdomain> 
 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>  <3F64FEAF.1070601@ximian.com>
  <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
 <1063650478.1516.0.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003, Kevin Breit wrote:

>  iOn Sun, 2003-09-14 at 20:57, Zwane Mwaikambo wrote:
> > On Sun, 14 Sep 2003, Kevin Breit wrote:
> > 
> > > This unfortunately didn't help.  It still reboots right after it 
> > > uncompresses the kernel.
> > 
> > Please try the attached .config, if that works, start removing things like 
> > ACPI from your configuration.
> 
> I disabled ACPI and that didn't help.  I reenabled it now and I'm
> looking for other options to disable.  But I don't know where to start. 
> Any suggestions?

Sure, but let's take it off the mailing list.
