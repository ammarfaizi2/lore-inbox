Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030200AbWBNKK5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030200AbWBNKK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:10:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWBNKK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:10:57 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:30954 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030200AbWBNKK4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:10:56 -0500
Date: Tue, 14 Feb 2006 11:10:38 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 00/12] hrtimer patches
Message-ID: <Pine.LNX.4.61.0602141057320.30994@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here is new version of the hrtimer patches sorted by priority. I dropped 
the remaining time patch, the const patch doesn't produce a larger kernel 
with gcc3 and I also added the acks so far.
I consider the first four patches the most important and the remaining 
patches simple enough, that I think they're still 2.6.16 material.

bye, Roman
