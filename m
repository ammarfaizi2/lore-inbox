Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbTIOO4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 10:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbTIOO4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 10:56:51 -0400
Received: from peabody.ximian.com ([141.154.95.10]:54996 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S261442AbTIOO4u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 10:56:50 -0400
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
Message-Id: <1063637805.1673.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 15 Sep 2003 10:56:46 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-09-14 at 20:57, Zwane Mwaikambo wrote:
> On Sun, 14 Sep 2003, Kevin Breit wrote:
> 
> > This unfortunately didn't help.  It still reboots right after it 
> > uncompresses the kernel.
> 
> Please try the attached .config, if that works, start removing things like 
> ACPI from your configuration.

When I did a make it kept asking me for configuration options ("Do you
want to add this? [Y/n]") I'm not sure what to say to all these.

Thanks

Kevin

