Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264607AbTFYPws (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264608AbTFYPwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:52:47 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:9988 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264607AbTFYPwo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:52:44 -0400
Date: Wed, 25 Jun 2003 18:06:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Larry McVoy <lm@work.bitmover.com>, Andre Tomt <andre@tomt.net>,
       linux-kernel@vger.kernel.org
Subject: Re: bkbits.net web UI oddities after last crash
Message-ID: <20030625160650.GA1470@mars.ravnborg.org>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Andre Tomt <andre@tomt.net>, linux-kernel@vger.kernel.org
References: <1056475651.7646.128.camel@slurv.ws.pasop.tomt.net> <20030625154602.GA25213@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625154602.GA25213@work.bitmover.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 08:46:02AM -0700, Larry McVoy wrote:
> On Tue, Jun 24, 2003 at 07:27:31PM +0200, Andre Tomt wrote:
> > Hi
> > 
> > I noticed some rather strange behavior from
> > http://linux.bkbits.net:8080/linux-2.4
> 
> I put up a new release that used MD5 based names for revision numbers rather
> than the revision numbers (sort of like naming a file by inode number) 
> because the revision numbers shift around on you.

Using cset numbers in the interface would make it a bit easier to
understand.

> It has bugs.  Once we
> work out the bugs the plus is that you'll be able to post a URL and it 
> will always get people to the same data which is not true today.

Good to hear - drop a mail when you think the bugs are fixed so
we know when to give feedback. (Eventually at bitkeeper-users ml)

	Sam
