Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262264AbVCOFkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVCOFkW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262268AbVCOFkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:40:22 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:15313 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262264AbVCOFkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:40:17 -0500
Date: Mon, 14 Mar 2005 21:37:48 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: john stultz <johnstul@us.ibm.com>
cc: lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       george anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich.Windl@rz.uni-regensburg.de, linux@dominikbrodowski.de,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>, Max <masbock@us.ibm.com>,
       mahuja@us.ibm.com, Nishanth Aravamudan <nacc@us.ibm.com>,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v. A3)
In-Reply-To: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.58.0503142116320.16655@schroedinger.engr.sgi.com>
References: <1110590655.30498.327.camel@cog.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Note that similarities exist between the posix clock and the time sources.
Will all time sources be exportable as posix clocks?


