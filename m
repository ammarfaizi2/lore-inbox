Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932540AbWEXBuy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932540AbWEXBuy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 21:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbWEXBuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 21:50:54 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55259 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932540AbWEXBuy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 21:50:54 -0400
Message-ID: <4473BBEE.6030509@garzik.org>
Date: Tue, 23 May 2006 21:50:38 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Matthew Garrett <mgarrett@chiark.greenend.org.uk>
CC: Jon Smirl <jonsmirl@gmail.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org, "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <200605230048.14708.dhazelton@enter.net> <200605230048.14708.dhazelton@enter.net> <9e4733910605231017g146e16dfnd61eb22a72bd3f5f@mail.gmail.com> <E1Fifom-0003qk-00@chiark.greenend.org.uk>
In-Reply-To: <E1Fifom-0003qk-00@chiark.greenend.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.1 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.1 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
> In the long run, graphics drivers need to know how to program cards from 
> scratch rather than depending on 80x25 text mod being there for them.

True in theory, but that's a task of immense proportions.  The Video 
BIOS is often the only place where RAM timings and other board-specific 
data lives.

	Jeff



