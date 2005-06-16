Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261734AbVFPEdV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261734AbVFPEdV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 00:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVFPEdV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 00:33:21 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:31898 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261734AbVFPEdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 00:33:18 -0400
From: Jeremy Maitin-Shepard <jbms@cmu.edu>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Patrick McFarland <pmcfarland@downeast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alexey Zaytsev <alexey.zaytsev@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: A Great Idea (tm) about reimplementing NLS.
References: <f192987705061303383f77c10c@mail.gmail.com>
	<f192987705061310202e2d9309@mail.gmail.com>
	<1118690448.13770.12.camel@localhost.localdomain>
	<200506152149.06367.pmcfarland@downeast.net>
	<20050616023630.GC9773@thunk.org>
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-1: winter into spring
Date: Thu, 16 Jun 2005 00:33:16 -0400
In-Reply-To: <20050616023630.GC9773@thunk.org> (Theodore Ts'o's message of
	"Wed, 15 Jun 2005 22:36:30 -0400")
Message-ID: <87y89a7wfn.fsf@jbms.ath.cx>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> [snip]

> Ext2/3's encoding has always been utf-8.  Period.

In what way does Ext2/3 know or care about file name encoding?  Doesn't
it just store an arbitrary 8-byte string?  Couldn't someone claim that
from the start it was designed to use iso8859-1 just as easily as you
can claim it was designed to use utf-8?

-- 
Jeremy Maitin-Shepard
