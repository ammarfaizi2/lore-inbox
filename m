Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270850AbTGVO7j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 10:59:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270855AbTGVO7j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 10:59:39 -0400
Received: from pro5.mtco.com ([207.179.200.251]:34718 "HELO pro5.mtco.com")
	by vger.kernel.org with SMTP id S270850AbTGVO7i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 10:59:38 -0400
From: Tom Felker <tcfelker@mtco.com>
Subject: Re: Scheduler starvation (2.5.x, 2.6.0-test1)
Date: Tue, 22 Jul 2003 10:14:46 -0500
User-Agent: Pan/0.14.0 (I'm Being Nibbled to Death by Cats!)
Message-Id: <pan.2003.07.22.15.14.44.457281@mtco.com>
References: <bUil.2D8.11@gated-at.bofh.it>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jul 2003 03:40:09 +0200, Simon Kirby wrote:
> 
> Is anybody else seeing this or is it something to do with my setup here?
> 
> Simon-

I see this too, on a much faster system.  My browsing habit is to open a
link in a new tab, and immediately click on that tab.  The mouse gets
noticeably jumpy right after clicking the link.  I may be jaded by my
2.4.20-gentoo kernel which never did this, but still...

My system is a 2.4 GHz P4 running Gentoo, 2.6.0-test1 (tainted with
nVidia), and Mozilla Firebird, with a USB mouse.

-- 
Tom Felker

Alchemists became chemists when they stopped keeping secrets.

