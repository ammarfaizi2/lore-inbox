Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTLBQIz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 11:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbTLBQIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 11:08:55 -0500
Received: from havoc.gtf.org ([63.247.75.124]:36752 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262251AbTLBQIy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 11:08:54 -0500
Date: Tue, 2 Dec 2003 11:08:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
Message-ID: <20031202160853.GB22608@gtf.org>
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <200312011226.04750.nbensa@gmx.net> <20031202115436.GA10288@physik.tu-cottbus.de> <20031202120315.GK13388@conectiva.com.br> <20031202131311.GA10915@physik.tu-cottbus.de> <3FCC95BB.60205@wmich.edu> <20031202160136.GB10915@physik.tu-cottbus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031202160136.GB10915@physik.tu-cottbus.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 05:01:36PM +0100, Ionut Georgescu wrote:
> I can understand that, but I don't take 2.6 for an answer.  2.4 is not
> yet dead and it won't be for a long time, just as 2.2 has gotten to
> 2.2.25, although 2.4.0 was out when, 3 years ago ?

2.4 has continued life, yes.

But the real question is, should 2.4 continue to be developed?

I agree with Marcelo, increasingly the answer should be "No".  New
features and core changes should be intended for 2.6.  Bug fixes,
security errata, and the like will always be OK for 2.4.  Just like Alan
continues to release new 2.2.x releases, when major bugs are found.

There needs to be a progressive tightening of patch acceptance standards
in 2.4, IMO...  and Marcelo announced he will be doing just that.

	Jeff



