Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265311AbUFHVCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbUFHVCl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 17:02:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265314AbUFHVCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 17:02:41 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:18184 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S265311AbUFHVCi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 17:02:38 -0400
Date: Tue, 8 Jun 2004 23:08:46 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild make deb patch
Message-ID: <20040608210846.GA5216@mars.ravnborg.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040607141353.GK21794@wiggy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607141353.GK21794@wiggy.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 04:13:53PM +0200, Wichert Akkerman wrote:
> I originally posted this before 2.6.0 was out and was told to wait until 
> things have stabilized a bit. At least from my point of view that has
> happened by now so I'm bringing this one up again.
> 
> kbuild has had a rpm make target for some time now. Since the concept of
> kernel packages is quite convenient I added a deb target as well, using
> the patch below.
> 
> Since I'm (still) not familiar with kbuild Makefile bits are quite
> rough, but they Work For Me(Tm).

I'm in progress of doing some infrastructure work to better support building
different packages. I have requests for .tar.gz, tar.gz2 as well
as deb.

I hope to post a few patches later this week.
I will include your script in the patch-set then.

	Sam
