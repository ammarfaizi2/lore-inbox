Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263475AbUGFGxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263475AbUGFGxy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 02:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263429AbUGFGxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 02:53:54 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:7605 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S263475AbUGFGrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 02:47:08 -0400
Subject: Re: [PATCH] gcc 3.5 fixes
From: David Woodhouse <dwmw2@infradead.org>
To: bert hubert <ahu@ds9a.nl>
Cc: Mark Adler <madler@alumni.caltech.edu>, Jesse Stockall <stockall@magma.ca>,
       Paul Jackson <pj@sgi.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040706061149.GA3557@outpost.ds9a.nl>
References: <2e9is-5YT-1@gated-at.bofh.it> <2e9iu-5YT-5@gated-at.bofh.it>
	 <2ecq2-80i-1@gated-at.bofh.it>
	 <7ab39013.0407042237.40ea9035@posting.google.com>
	 <20040705064010.C9BFB5F7AA@attila.bofh.it>
	 <9FC7DA98-CEA3-11D8-B083-000A95820F30@alumni.caltech.edu>
	 <20040705144436.62544a3d.pj@sgi.com>
	 <1C37F9C6-CEEA-11D8-B083-000A95820F30@alumni.caltech.edu>
	 <1089085868.8452.2.camel@localhost>
	 <1820F1EE-CF07-11D8-B083-000A95820F30@alumni.caltech.edu>
	 <20040706061149.GA3557@outpost.ds9a.nl>
Content-Type: text/plain
Message-Id: <1089096416.4636.1142.camel@imladris.demon.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Tue, 06 Jul 2004 07:46:56 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-07-06 at 08:11 +0200, bert hubert wrote:
> On Mon, Jul 05, 2004 at 09:43:58PM -0700, Mark Adler wrote:
> > On Jul 5, 2004, at 8:51 PM, Jesse Stockall wrote:
> > >Did I miss something or are you saying that the version in the kernel
> > >has a security vulnerability?
> > 
> > If the kernel has 1.1.3, then yes.  You can get 1.1.4 here, which 
> > remedies that vulnerability:
> 
> I seem to recall that vulnerability was fixed in place, without upgrading to
> 1.1.4.

Indeed, but it's probably time we upgraded to 1.2.

-- 
dwmw2


