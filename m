Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263735AbUHJJnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263735AbUHJJnq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263784AbUHJJnq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:43:46 -0400
Received: from [203.12.160.103] ([203.12.160.103]:31702 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S263735AbUHJJnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:43:43 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
In-Reply-To: <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <20040809113829.GB9793@elf.ucw.cz>
	 <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
	 <20040809212949.GA1120@elf.ucw.cz>
	 <Pine.LNX.4.50.0408092156480.24154-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1092130981.2676.1.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 10 Aug 2004 19:43:02 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-08-10 at 15:03, Patrick Mochel wrote:
> Once the swsusp consolidation is merged upstream, I will merge a new
> device power model in -mm, and we can start working on the drivers. How
> does that sound?

Do you want me to merge before or after all this is done; I'm a bit
concerned that you guys are expending effort (well, Pavel is), getting
SMP and Highmem going when I already have a working version that -
unless the plans have changed - we were intending to merge too.

Nigel

