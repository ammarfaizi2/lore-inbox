Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261344AbUJ3VoS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbUJ3VoS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 17:44:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261345AbUJ3VmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 17:42:13 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:33153 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261344AbUJ3Viy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 17:38:54 -0400
Date: Sun, 31 Oct 2004 01:39:42 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jean-Christophe Dubois <jdubois@mc.com>,
       kai@germaschewski.name, sam@ravnborg.org
Subject: Re: [PATCH 2.6.9] kbuild warning fixes on Solaris 9
Message-ID: <20041030233942.GH9592@mars.ravnborg.org>
Mail-Followup-To: Tom Rini <trini@kernel.crashing.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Jean-Christophe Dubois <jdubois@mc.com>, kai@germaschewski.name,
	sam@ravnborg.org
References: <20041025224907.GL25154@smtp.west.cox.net> <20041026221408.GB30918@mars.ravnborg.org> <20041026204132.GD926@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041026204132.GD926@smtp.west.cox.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2004 at 01:41:32PM -0700, Tom Rini wrote:
> > Looks much better. Applied.
> 
> Great.  A coworker of mine give them a look-over and spotted a few
> places where I missed changing some casts.

Applied,

	Sam
