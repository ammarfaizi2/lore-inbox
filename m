Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264046AbTJ1RR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 12:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264053AbTJ1RR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 12:17:27 -0500
Received: from fw.osdl.org ([65.172.181.6]:58603 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264046AbTJ1RRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 12:17:25 -0500
Date: Tue, 28 Oct 2003 09:16:56 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@osdlab.pdx.osdl.net>
To: Mark Bellon <mbellon@mvista.com>
cc: <linux-kernel@vger.kernel.org>,
       <linux-hotplug-devel@lists.sourceforge.net>
Subject: Re: ANNOUNCE: User-space System Device Enumeration (uSDE)
In-Reply-To: <3F9DA5A6.3020008@mvista.com>
Message-ID: <Pine.LNX.4.33.0310280901490.7139-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> The uSDE was built in response to a set of telco and embedded community
> requirements. We found it difficult to express our ideas. Everyone
> wanted to see code and documentation. Here is the code and the initial
> documentation. This is a starting point...

I find it difficult to see your justification for designing a project from
scratch instead of contributing your time, effort, and ideas to a pair of
already existing, albeit immature, projects that do exactly the same
thing.

Please note that I'm not trying to incite yet another device naming flame
war, but you have to understand how frustrating it is to see you guys make
the same mistakes over and over, ad inifitum.

Let's review. SDET was posted several months ago by the Montavista telco
group as a 2.4 solution that was driven by customer requirements. So be
it.

In the last year, you (and/or your group) has posted several proposed
device naming solutions; each of which were shot down because of
over-design, misdirection, or simply tastelessness. Each time we
encouraged you to align yourselves with the overall design goals or simply
contribute to existing projects.

Personal contact in Ottawa resulted the same message. IIRC, many if not
all, of the atttending MV telco engineers even saw Greg's talk on udev.

In the time since, you've designed and written a solution from scratch,
without even trying to contribute to the udev effort. (And while, I might
add, another MV engineer contributed several patches to in his free time
to help package and productize it.)

I fail to see your point in this project. AFAIC, you've wasted your time.
It surely can't be customer requirements, as I highly doubt any customer
solutions are based on a 2.6 kernel yet. You've completely duplicated the
efforts of a project destined to become the de facto standard for the
requirement you're trying to fulfill, for what gain?



	Pat

