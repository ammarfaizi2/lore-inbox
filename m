Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263828AbTJ1C6J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 21:58:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263830AbTJ1C6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 21:58:09 -0500
Received: from auth22.inet.co.th ([203.150.14.104]:14086 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S263828AbTJ1C6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 21:58:08 -0500
From: Michael Frank <mhf@linuxmail.org>
To: Nigel Cunningham <ncunningham@clear.net.nz>,
       Nick Piggin <piggin@cyberone.com.au>
Subject: Re: 2.6.0-test8/test9 io scheduler needs tuning?
Date: Tue, 28 Oct 2003 10:57:34 +0800
User-Agent: KMail/1.5.2
Cc: cliff white <cliffw@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200310261201.14719.mhf@linuxmail.org> <3F9DAF2C.8010308@cyberone.com.au> <1067305071.1693.14.camel@laptop-linux>
In-Reply-To: <1067305071.1693.14.camel@laptop-linux>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310281057.34982.mhf@linuxmail.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 28 October 2003 09:37, Nigel Cunningham wrote:
> I'll try it with my software suspend patch. Under 2.4, I get around 45
> pages per jiffy written when suspending. Under 2.6, I'm currently
> getting 2-4, so any improvement should be obvious!

Strange, I had no problems suspending/resuming with -alpha1 - it seems to do "normal (2.4)" speed ...

Will try again and let you know.

Regards
Michael

