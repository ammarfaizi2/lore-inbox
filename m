Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbTJXRyb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Oct 2003 13:54:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262440AbTJXRyb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Oct 2003 13:54:31 -0400
Received: from thunk.org ([140.239.227.29]:36225 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S262433AbTJXRya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Oct 2003 13:54:30 -0400
Date: Fri, 24 Oct 2003 13:54:13 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031024175413.GA733@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	bill davidsen <davidsen@tmr.com>, linux-kernel@vger.kernel.org
References: <3F8E552B.3010507@users.sf.net> <20031022025602.GH17713@pegasys.ws> <20031022122251.A3921@borg.org> <3F97498D.9050704@storm.ca> <bnbo18$49b$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bnbo18$49b$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 24, 2003 at 05:37:44PM +0000, bill davidsen wrote:
> 
> No argument, but the performance of urandom is quite poor in terms of
> speed and having every application generate their own number using
> their own possibly badly flawed algorithm certainly qualifies as
> undesirable.

That's what shared libraries are for....


						- Ted
