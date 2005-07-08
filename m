Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262915AbVGHWUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262915AbVGHWUA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 18:20:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262925AbVGHWSf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 18:18:35 -0400
Received: from ncc1701.cistron.net ([62.216.30.38]:6339 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP id S262915AbVGHWCw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 18:02:52 -0400
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: Instruction Tracing for Linux
Date: Fri, 8 Jul 2005 22:02:47 +0000 (UTC)
Organization: Cistron
Message-ID: <damt67$2a3$1@news.cistron.nl>
References: <DC392CA07E5A5746837A411B4CA2B713010D7791@sekhmet.ad.newisys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1120860167 2371 194.109.0.112 (8 Jul 2005 22:02:47 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: mikevs@cistron.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <DC392CA07E5A5746837A411B4CA2B713010D7791@sekhmet.ad.newisys.com>,
Adnan Khaleel <Adnan.Khaleel@newisys.com> wrote:
>Thanks for your suggestions. I have been working with Simics, SimNow and
>Bochs. I've had mixed luck with all of them. Although Simics should be
>the most promising, I've really had
>an uphill struggle with it especially when it comes to x86-64. I've been
>playing around with Bochs and most likely will end up using that but it
>has its drawbacks as well. 
>
>Even if I can't trace the kernel, is there anything available for just
>the user space stuff?

You might be able to get valgrind or cachegrind to do what you need..

Mike.

