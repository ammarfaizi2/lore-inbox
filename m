Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTIOS2D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 14:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbTIOS2D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 14:28:03 -0400
Received: from peabody.ximian.com ([141.154.95.10]:55002 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261234AbTIOS2B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 14:28:01 -0400
Subject: Re: Need fixing of a rebooting system
From: Kevin Breit <mrproper@ximian.com>
Reply-To: mrproper@ximian.com
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
References: <1063496544.3164.2.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309131945130.3274@montezuma.fsmlabs.com>
	 <3F6450D7.7020906@ximian.com>
	 <Pine.LNX.4.53.0309140904060.22897@montezuma.fsmlabs.com>
	 <1063561687.10874.0.camel@localhost.localdomain>
	 <Pine.LNX.4.53.0309141741050.5140@montezuma.fsmlabs.com>
	 <3F64FEAF.1070601@ximian.com>
	 <Pine.LNX.4.53.0309142055560.5140@montezuma.fsmlabs.com>
Content-Type: text/plain
Organization: Ximian, Inc.
Message-Id: <1063650478.1516.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 14:27:59 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 iOn Sun, 2003-09-14 at 20:57, Zwane Mwaikambo wrote:
> On Sun, 14 Sep 2003, Kevin Breit wrote:
> 
> > This unfortunately didn't help.  It still reboots right after it 
> > uncompresses the kernel.
> 
> Please try the attached .config, if that works, start removing things like 
> ACPI from your configuration.

I disabled ACPI and that didn't help.  I reenabled it now and I'm
looking for other options to disable.  But I don't know where to start. 
Any suggestions?

Thanks

Kevin Breit

