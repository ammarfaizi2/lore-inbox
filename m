Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVCOSoG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVCOSoG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 13:44:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVCOSko
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 13:40:44 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:16975 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261697AbVCOShZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 13:37:25 -0500
Date: Tue, 15 Mar 2005 19:37:42 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: David Greaves <david@dgreaves.com>
Cc: Greg KH <greg@kroah.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Greg Norris <haphazard@kc.rr.com>, linux-kernel@vger.kernel.org,
       akpm <akpm@osdl.org>
Subject: Re: [BUG] Re: [PATCH] scripts/patch-kernel: use EXTRAVERSION
Message-ID: <20050315183742.GA8278@mars.ravnborg.org>
Mail-Followup-To: David Greaves <david@dgreaves.com>,
	Greg KH <greg@kroah.com>, "Randy.Dunlap" <rddunlap@osdl.org>,
	Greg Norris <haphazard@kc.rr.com>, linux-kernel@vger.kernel.org,
	akpm <akpm@osdl.org>
References: <Pine.LNX.4.58.0408140344110.1839@ppc970.osdl.org> <20040814115548.A19527@infradead.org> <Pine.LNX.4.58.0408140404050.1839@ppc970.osdl.org> <411E0A37.5040507@anomalistic.org> <20040814205707.GA11936@yggdrasil.localdomain> <20040818135751.197ce3c9.rddunlap@osdl.org> <20040822204002.GB8639@mars.ravnborg.org> <42370A3A.6020206@dgreaves.com> <20050315162545.GB24796@kroah.com> <42372342.90301@dgreaves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42372342.90301@dgreaves.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
> OK - should patch-kernel be deprecated?
> Should ketchup go in scripts/

When Matt's send me an updated ketchup I will add it to scripts and
delete patch-kernel.
Well it may be named patch-kernel in scripts/.

	Sam
