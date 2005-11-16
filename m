Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030278AbVKPRlU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030278AbVKPRlU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:41:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVKPRlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:41:20 -0500
Received: from xenotime.net ([66.160.160.81]:50354 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1030278AbVKPRlT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:41:19 -0500
Date: Wed, 16 Nov 2005 09:41:16 -0800 (PST)
From: "Randy.Dunlap" <rdunlap@xenotime.net>
X-X-Sender: rddunlap@shark.he.net
To: George Anzinger <george@mvista.com>
cc: Alex Williamson <alex.williamson@hp.com>, rmk+serial@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts (take 2)
In-Reply-To: <437B6C9C.3060307@mvista.com>
Message-ID: <Pine.LNX.4.58.0511160939180.23982@shark.he.net>
References: <1132158489.5457.10.camel@tdi> <437B6C9C.3060307@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, George Anzinger wrote:

> Could you _please_ not put inline patches after the signature mark ("-- ").  In my mailer (mozilla)
> this causes the patch to be greyed out and, more importantly, NOT included in a reply.  This, in
> turn, makes it hard to comment on details in the patch.


Would it help if Alex used the documented canonical patch format,
using "---" instead of "-- "?  I sorta doubt it.

BTW, George, please hit Return/Enter around column 70+...
Thanks.

---
~Randy
