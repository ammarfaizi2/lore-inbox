Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269072AbUJQH13@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269072AbUJQH13 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 03:27:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269073AbUJQH13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 03:27:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:46732 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S269072AbUJQH1X
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 03:27:23 -0400
Date: Sun, 17 Oct 2004 11:27:30 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Albert Cahalan <albert@users.sf.net>
Cc: Dan Kegel <dank@kegel.com>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       sam@ravnborg.org
Subject: Re: Building on case-insensitive systems
Message-ID: <20041017092730.GA9081@mars.ravnborg.org>
Mail-Followup-To: Albert Cahalan <albert@users.sf.net>,
	Dan Kegel <dank@kegel.com>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	sam@ravnborg.org
References: <1097989574.2674.14246.camel@cube> <4171F741.2070209@kegel.com> <1097991836.2666.14274.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097991836.2666.14274.camel@cube>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 17, 2004 at 01:43:56AM -0400, Albert Cahalan wrote:
> > 
> > You are betting that you can force developers to switch away
> > from Windows and MacOSX workstations.
> 
> Actually, I'm betting that "required to build product"
> is a magic phrase that overrides corporate IT's desire
> to brutally enforce a Microsoft-only environment.

Seems you are not part of one of these organisations.
That argument will not suffice.

Try to estimate the cost associated with the shift:
- Training
- Less efficiency in a period
- Missing important tools so a terminal service is needed
- etc.

The valid solution here would be to deploy a Linux server.
But then your arguments suffer compared to other OS'es where
everything is running on the users current host - why have
the hassle with a Linux server.

	Sam 
