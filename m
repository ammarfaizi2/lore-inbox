Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267493AbUHJQgG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267493AbUHJQgG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267516AbUHJQfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:35:52 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:35260 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267534AbUHJQSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:18:22 -0400
Date: Tue, 10 Aug 2004 18:18:13 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, dsaxena@plexity.net, greg@kroah.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.6] Remove spaces from PCI IDE pci_driver.name field
Message-ID: <20040810161813.GC21534@louise.pinerecords.com>
References: <20040810001316.GA7292@plexity.net> <1092096699.14934.4.camel@localhost.localdomain> <20040810021209.GA10495@plexity.net> <1092138774.16979.13.camel@localhost.localdomain> <20040810155701.GB21534@louise.pinerecords.com> <1092154407.10794.14.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1092154407.10794.14.camel@mindpipe>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug-10 2004, Tue, 12:13 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> > Sure, but while with a GUI you can click on almost anything, on the
> > command line spaces in filenames have always been a real pain in
> > the ass, so let's not pretend otherwise.
> Ever heard of tab completion?  Think of it as click for the command line.

Most completing algorithms are not (cannot be) smart enough to know
context, so the escaping they choose is not necessarily appropriate.

> Seriously, do you really *prefer* filenames like
> Foo_Bar-Baa_Baaz_Quux.mp3?

Yes, and I don't think I'm alone.

-- 
Tomas Szepe <szepe@pinerecords.com>
