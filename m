Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263395AbTH0OXv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 10:23:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263397AbTH0OXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 10:23:51 -0400
Received: from ns2.uk.superh.com ([193.128.105.170]:21378 "EHLO
	ns2.uk.superh.com") by vger.kernel.org with ESMTP id S263395AbTH0OXu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 10:23:50 -0400
Date: Wed, 27 Aug 2003 15:23:08 +0100
From: Richard Curnow <Richard.Curnow@superh.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
       jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030827142308.GC3140@malvern.uk.w2k.superh.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Jim Houston <jim.houston@comcast.net>, linux-kernel@vger.kernel.org,
	jim.houston@ccur.com
References: <1061498486.3072.308.camel@new.localdomain> <20030825040514.GA20529@mail.jlokier.co.uk> <20030826122621.GB3140@malvern.uk.w2k.superh.com> <20030827140121.GA1973@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030827140121.GA1973@mail.jlokier.co.uk>
X-OS: Linux 2.6.0-test2-mm5 i686
User-Agent: Mutt/1.5.4i
X-OriginalArrivalTime: 27 Aug 2003 14:23:49.0889 (UTC) FILETIME=[D5812F10:01C36CA6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jamie Lokier <jamie@shareable.org> [2003-08-27]:
> Here is a more universal test:
> 
[snip]

> 	- exit with status 0 on 2.6 kernels

Yes, confirmed, that's what it did on 2.6.0-test2-mm5 here.  Sorry, I
can't try 2.4 right now.

-- 
Richard \\\ SuperH Core+Debug Architect /// .. At home ..
  P.    /// richard.curnow@superh.com  ///  rc@rc0.org.uk
Curnow  \\\ http://www.superh.com/    ///  www.rc0.org.uk
