Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269273AbTGJNsi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 09:48:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269278AbTGJNsi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 09:48:38 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:46483 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S269273AbTGJNsh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 09:48:37 -0400
Date: Thu, 10 Jul 2003 08:36:44 -0400
From: Ben Collins <bcollins@debian.org>
To: Bob Gill <gillb4@telusplanet.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Firewire in 2.5.74 --Close to joy, but not quite
Message-ID: <20030710123644.GE439@phunnypharm.org>
References: <1057823705.6248.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1057823705.6248.25.camel@localhost.localdomain>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 10, 2003 at 01:55:05AM -0600, Bob Gill wrote:
> I had been having problems with building 2.5.74.  First ACPI went out,
> then firewire went out.  ACPI is still out but I got help with
> firewire.  I added #include <linux/pci.h> to sbp2.c.  Joy!  compiling
> sbp2 didn't kill the whole kernel compile.  Unfortunately on boot, there
> is still no joy.  It coughs up nasty error messages (that's the bad
> news).  The good news is that dmesg caught all of it.  I present it to
> you here.  If it is something I am doing, (or even appears something I
> am doing) please reply and I will attempt any an all requested changes
> or tests.  Thanks in advance,

Thanks for the info. I'm checking into now.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
