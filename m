Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262227AbVDOXY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262227AbVDOXY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVDOXY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:24:59 -0400
Received: from gate.crashing.org ([63.228.1.57]:51403 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262227AbVDOXY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:24:57 -0400
Subject: Re: 2.6.12-rc2-mm3
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Juergen Kreileder <jk@blackdown.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <87u0m7aogx.fsf@blackdown.de>
References: <20050411012532.58593bc1.akpm@osdl.org>
	 <87wtr8rdvu.fsf@blackdown.de>  <87u0m7aogx.fsf@blackdown.de>
Content-Type: text/plain
Date: Sat, 16 Apr 2005 09:23:36 +1000
Message-Id: <1113607416.5462.212.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 20:23 +0200, Juergen Kreileder wrote:
> Juergen Kreileder <jk@blackdown.de> writes:
> 
> > Andrew Morton <akpm@osdl.org> writes:
> >
> >> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm3/
> >
> > I'm getting frequent lockups on my PowerMac G5 with rc2-mm3.
> 
> I think I finally found the culprit.  Both rc2-mm3 and rc1-mm1 work
> fine when I reverse the timer-* patches.
> 
> Any idea?  Bug in my ppc64 gcc?

Or a bug in those patches, I'll have a look as soon as I find 5 minutes.

Ben.


