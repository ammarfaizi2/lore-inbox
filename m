Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264255AbUEIIxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264255AbUEIIxO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 May 2004 04:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264315AbUEIIxO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 May 2004 04:53:14 -0400
Received: from port-212-202-41-96.reverse.qsc.de ([212.202.41.96]:48877 "EHLO
	rocklinux-consulting.de") by vger.kernel.org with ESMTP
	id S264255AbUEIIxA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 May 2004 04:53:00 -0400
Date: Sun, 09 May 2004 10:52:53 +0200 (CEST)
Message-Id: <20040509.105253.26927810.rene@rocklinux-consulting.de>
To: john@grabjohn.com
Cc: shemminger@osdl.org, linux-kernel@vger.kernel.org, rock-user@rocklinux.org
Subject: Re: Distributions vs kernel development
From: Rene Rebe <rene@rocklinux-consulting.de>
In-Reply-To: <200405090707.i49776Iv000342@81-2-122-30.bradfords.org.uk>
References: <409BB334.7080305@pobox.com>
	<20040509.084923.558886277.rene@rocklinux-consulting.de>
	<200405090707.i49776Iv000342@81-2-122-30.bradfords.org.uk>
X-Mailer: Mew version 3.1 on XEmacs 21.4.13 (Rational FORTRAN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Score: 0.0 (/)
X-Spam-Report: Spam detection software, running on the system "heap.localnet", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or block
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Hi, On: Sun, 9 May 2004 08:07:06 +0100, John Bradford
	<john@grabjohn.com> wrote: > > Since other use this chance to propose
	already well known > > distributions > > To be honest, why use a
	distribution at all, or if you do use one, why worry > about
	'following' it after installation, instead of using it as a base from >
	which to do your own thing? [...] 
	Content analysis details:   (0.0 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On: Sun, 9 May 2004 08:07:06 +0100,
    John Bradford <john@grabjohn.com> wrote:
> > Since other use this chance to propose already well known
> > distributions
> 
> To be honest, why use a distribution at all, or if you do use one, why worry
> about 'following' it after installation, instead of using it as a base from
> which to do your own thing?

In this case you might want to know that ROCK Linux is not yet another
distribution but a distribution build kit including and build system
to rebuild the whole distribution in a sorted and clean manner.

And no, it is not like Gentoo where you need to rebuild on each box or
so.

> Of course, it sounds like a lot more effort to install whatever you need from
> scratch, but you also more or less cut out distribution-specific issues, such
> as one package depending on another, and of course you get much more
> flexibility.

Well, as I mentioned there is not much ROCK Linux specific in ROCK
Linux. Mostly it consists of this auto build system including a huge
set (1200 at the moment) package descriptions allowing convenient
single package or whole system (re-)builds.

  http://www.rocklinux.org/handbook.html

Sincerely yours,
  René Rebe
    - ROCK Linux stable release maintainer

--  
René Rebe - Europe/Germany/Berlin
  rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de

