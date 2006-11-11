Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947308AbWKKVlr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947308AbWKKVlr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 16:41:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbWKKVlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 16:41:47 -0500
Received: from hansmi.home.forkbomb.ch ([213.144.146.165]:19997 "EHLO
	hansmi.home.forkbomb.ch") by vger.kernel.org with ESMTP
	id S1754877AbWKKVlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 16:41:46 -0500
Date: Sat, 11 Nov 2006 22:41:43 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Stelian Pop <stelian@popies.net>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Jean Delvare <khali@linux-fr.org>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nicolas@boichat.ch
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-ID: <20061111214143.GA25609@hansmi.ch>
References: <1163280972.32084.13.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1163280972.32084.13.camel@localhost.localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2006 at 10:36:11PM +0100, Stelian Pop wrote:
> This driver adds support for the Apple Motion Sensor (AMS) as found in 2005
> revisions of Apple PowerBooks and iBooks.  It implements both the PMU and
> I²C variants.

I've modified my driver to use an accelerometer class. Do you want the
code?

Thanks,
Michael
