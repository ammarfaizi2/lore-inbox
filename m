Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263642AbTE0Ob0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 10:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263643AbTE0Ob0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 10:31:26 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:16656 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263642AbTE0ObY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 10:31:24 -0400
Date: Tue, 27 May 2003 07:44:29 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ryan Anderson <ryan@michonline.com>
cc: Aaron Lehmann <aaronl@vitelus.com>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [2.5] [Cool stuff] "checking" mode for kernel builds
In-Reply-To: <20030527091644.GF585@michonline.com>
Message-ID: <Pine.LNX.4.44.0305270742130.20127-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 May 2003, Ryan Anderson wrote:
> 
> How's this for a hack that makes it work a bit better?

Well, since it clearly isn't any worse than what I have now, I'll just say 
"hell yes!", and apply it.

In fact, I'll just make the old gcc paths go away entirely, as this should 
make them be non-issues.

		Linus

