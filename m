Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272638AbTHEK7X (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 06:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272644AbTHEK7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 06:59:23 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:43933 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S272638AbTHEK7W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 06:59:22 -0400
Date: Tue, 5 Aug 2003 12:59:01 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.22-pre10] SAK: If a process is killed by SAK, give us an info about which one was killed
Message-ID: <20030805105901.GA329@elf.ucw.cz>
References: <200307312254.16964.m.c.p@wolk-project.de> <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059739764.18399.0.camel@dhcp22.swansea.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > $subject says it all.
> > 
> > Please apply for 2.4.22-pre10. Thank you :)
> > 
> > ciao, Marc
> 
> This is potentially private information. It shouldnt be reported
> I disagree with the patch

I agree it is not good enough for 2.4.X, but it looks good to me for
2.6. That information can be get by ps, right? If we decide it is not
okay to print process names to syslog, maybe oom killer should be
fixed, too?
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
