Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWIZKJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWIZKJt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751037AbWIZKJt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:09:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:33156 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750814AbWIZKJs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:09:48 -0400
Date: Tue, 26 Sep 2006 12:08:47 +0200
From: Stefan Seyfried <seife@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Pavel Machek <pavel@ucw.cz>, Nigel Cunningham <ncunningham@linuxmail.org>,
       linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: When will the lunacy end? (Was Re: [PATCH] uswsusp: add pmops->{prepare,enter,finish} support (aka "platform mode"))
Message-ID: <20060926100847.GC5782@suse.de>
References: <20060925071338.GD9869@suse.de> <1159220043.12814.30.camel@nigel.suspend2.net> <20060925144558.878c5374.akpm@osdl.org> <20060925224500.GB2540@elf.ucw.cz> <20060925160648.de96b6fa.akpm@osdl.org> <20060925232151.GA1896@elf.ucw.cz> <20060925172240.5c389c25.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060925172240.5c389c25.akpm@osdl.org>
X-Operating-System: SUSE Linux Enterprise Desktop 10 (i586), Kernel 2.6.18-3-seife
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 05:22:40PM -0700, Andrew Morton wrote:
> On Tue, 26 Sep 2006 01:21:51 +0200
> Pavel Machek <pavel@ucw.cz> wrote:
 
> > 15 seconds spend within drivers is definitely _not_ okay.
> 
> I assumed it was the same for everyone else ;)

No, it is not. Although i must admit that Pavel actually seems to _never_
have the bad hardware, and i seem to _always_ get the bad hardware, that
is slow to suspend :-)

(it might sometimes also be software setup problems, not only hardware)
-- 
Stefan Seyfried
QA / R&D Team Mobile Devices        |              "Any ideas, John?"
SUSE LINUX Products GmbH, Nürnberg  | "Well, surrounding them's out." 
