Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRJJWEP>; Wed, 10 Oct 2001 18:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277437AbRJJWEF>; Wed, 10 Oct 2001 18:04:05 -0400
Received: from 24-168-215-96.he.cox.rr.com ([24.168.215.96]:30599 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S277435AbRJJWDr>;
	Wed, 10 Oct 2001 18:03:47 -0400
Message-ID: <44355.192.168.65.5.1002751405.squirrel@maxwell.local>
Date: Wed, 10 Oct 2001 18:03:25 -0400 (EDT)
Subject: Re: Tainted Modules Help Notices
From: "Anthony DeRobertis" <asd@suespammers.org>
To: <kaos@ocs.com.au>
In-Reply-To: <16172.1002749316@ocs3.intra.ocs.com.au>
In-Reply-To: <16172.1002749316@ocs3.intra.ocs.com.au>
Cc: <sirmorcant@morcant.org>, <tkhoadfdsaf@hotmail.com>, <dwmw2@infradead.org>,
        <alan@lxorguk.ukuu.org.uk>, <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.0 [rc1])
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> To triage bug reports.  Any bug report against a tainted kernel is
> almost certain to be bounced with "your kernel contains code that
> we do not have the source for, send this bug report to the company
> that
> maintains the non-GPL code".

Couldn't this mess be solved with a module (optionally) containing a URL
to a source-code tarball? Modules that come with the kernel would point
to the relevant kernel sources on ftp.kernel.org.

This would alleviate all worry about things like closed-source BSD;
after all, anyone could check if there is source availible with wget.



