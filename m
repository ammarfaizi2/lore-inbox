Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1947319AbWKKWCh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1947319AbWKKWCh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Nov 2006 17:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1947320AbWKKWCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Nov 2006 17:02:37 -0500
Received: from sd291.sivit.org ([194.146.225.122]:11792 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1947319AbWKKWCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Nov 2006 17:02:36 -0500
Subject: Re: [PATCH] Apple Motion Sensor driver
From: Stelian Pop <stelian@popies.net>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Jean Delvare <khali@linux-fr.org>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nicolas@boichat.ch
In-Reply-To: <20061111214143.GA25609@hansmi.ch>
References: <1163280972.32084.13.camel@localhost.localdomain>
	 <20061111214143.GA25609@hansmi.ch>
Content-Type: text/plain; charset=ISO-8859-15
Date: Sat, 11 Nov 2006 23:00:17 +0100
Message-Id: <1163282417.32084.18.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le samedi 11 novembre 2006 à 22:41 +0100, Michael Hanselmann a écrit :
> On Sat, Nov 11, 2006 at 10:36:11PM +0100, Stelian Pop wrote:
> > This driver adds support for the Apple Motion Sensor (AMS) as found in 2005
> > revisions of Apple PowerBooks and iBooks.  It implements both the PMU and
> > I²C variants.
> 
> I've modified my driver to use an accelerometer class. 

Hmmm, I didn't know such a thing existed.

> Do you want the code?

Just make sure it gets submitted upstream so it gets no lost.

I don't have a particular use for the accelerometer myself, I was just
digging thru the pile of my local patches and I noticed that all the
work (mine, yours and others) on the ams device seemed on its way to be
lost, since nobody picked up the patch.

But if you're still actively working on it and plan to submit it later,
that's perfectly ok with me.

Stelian.
-- 
Stelian Pop <stelian@popies.net>

