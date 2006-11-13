Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755305AbWKMSLR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755305AbWKMSLR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 13:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755306AbWKMSLR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 13:11:17 -0500
Received: from smtp-101-monday.nerim.net ([62.4.16.101]:37129 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1755305AbWKMSLQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 13:11:16 -0500
Date: Mon, 13 Nov 2006 19:11:15 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stelian Pop <stelian@popies.net>
Cc: Michael Hanselmann <linux-kernel@hansmi.ch>, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       "Aristeu S. Rozanski F." <aris@cathedrallabs.org>,
       Johannes Berg <johannes@sipsolutions.net>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Paul Mackerras <paulus@samba.org>, Robert Love <rml@novell.com>,
       Rene Nussbaumer <linux-kernel@killerfox.forkbomb.ch>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       nicolas@boichat.ch
Subject: Re: [PATCH] Apple Motion Sensor driver
Message-Id: <20061113191115.fa5c5d6f.khali@linux-fr.org>
In-Reply-To: <1163367528.21258.2.camel@localhost.localdomain>
References: <1163280972.32084.13.camel@localhost.localdomain>
	<20061111214143.GA25609@hansmi.ch>
	<1163282417.32084.18.camel@localhost.localdomain>
	<20061112083705.GB25609@hansmi.ch>
	<1163367528.21258.2.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.20; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian,

On Sun, 12 Nov 2006 22:38:47 +0100, Stelian Pop wrote:
> Le dimanche 12 novembre 2006 à 09:37 +0100, Michael Hanselmann a écrit :
> [...]
> 
> > But since Nicolas is really busy since months, I'd say the submitted
> > code can go in. I'll then make a patch which adds the class.
> 
> Ok, cool, let's get it in then.
> 
> Who picks it up ? Jean ? Andrew ?

Depends to the answer to my question elsewhere in this thread. If we
decide that the accelerometer class and drivers belong to hwmon, I'll
take the patch (well it'll need to be submitted and reviewed first
anyway.) But if we decide that they belong to the input subsystem, I'd
rather let Dmitry handle it.

Thanks,
-- 
Jean Delvare
