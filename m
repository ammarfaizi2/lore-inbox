Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbWEWUhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbWEWUhV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 16:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWEWUhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 16:37:21 -0400
Received: from outmx010.isp.belgacom.be ([195.238.5.233]:57738 "EHLO
	outmx010.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S932163AbWEWUhU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 16:37:20 -0400
Date: Tue, 23 May 2006 22:37:09 +0200
From: Wim Van Sebroeck <wim@iguana.be>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/14/] Doc. sources: expose watchdog
Message-ID: <20060523203709.GA4651@infomag.infomag.iguana.be>
References: <20060521205810.64b631e2.rdunlap@xenotime.net> <20060522144347.07b08a8c.akpm@osdl.org> <20060522145832.ce45807a.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060522145832.ce45807a.rdunlap@xenotime.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

> > "Randy.Dunlap" <rdunlap@xenotime.net> wrote:
> > >
> > >  Documentation/watchdog/pcwd-watchdog.txt |   73 -------------------------------
> > >   Documentation/watchdog/watchdog-api.txt  |   17 -------
> > >   Documentation/watchdog/watchdog-simple.c |   15 ++++++
> > >   Documentation/watchdog/watchdog-test.c   |   68 ++++++++++++++++++++++++++++
> > >   Documentation/watchdog/watchdog.txt      |   23 ---------
> > 
> > Wouldn't it be better to move all the .c files into a new directory? 
> > Documentation/src or something?
> 
> I dunno.  I like using multiple subdirectories (like watchdog/,
> laptop/, block/, etc.) and not cluttering up Documentation/
> with them.

I think a "user" that wants to know something specific about watchdog drivers
will look in Documentation/watchdog and try to find what he need as fast as
he can. I would say Documentation/watchdog/src/ then...

Greetings,
Wim.

