Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275499AbTHMUb3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 16:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275500AbTHMUb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 16:31:29 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:12966 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S275499AbTHMUb2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 16:31:28 -0400
Date: Wed, 13 Aug 2003 15:30:49 -0500 (CDT)
From: Matt Domsch <Matt_Domsch@Dell.com>
X-X-Sender: mdomsch@humbolt.us.dell.com
Reply-To: Matt Domsch <Matt_Domsch@Dell.com>
To: Dave Jones <davej@redhat.com>
cc: Matthew Wilcox <willy@debian.org>, Jeff Garzik <jgarzik@pobox.com>,
       Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>,
       "David S. Miller" <davem@redhat.com>, <rddunlap@osdl.org>,
       <linux-kernel@vger.kernel.org>,
       <kernel-janitor-discuss@lists.sourceforge.net>
Subject: Re: C99 Initialisers
In-Reply-To: <20030813201610.GJ12953@redhat.com>
Message-ID: <Pine.LNX.4.44.0308131529490.14941-100000@humbolt.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This situation is exactly what the new_id stuff in sysfs is for AIUI.

And coincidentally, the e100 driver is what I hacked to test new_id with, 
so it's even pretty likely to work.  :-)

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com

