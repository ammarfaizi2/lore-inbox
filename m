Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262007AbTEEHaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 03:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262013AbTEEHaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 03:30:21 -0400
Received: from are.twiddle.net ([64.81.246.98]:53907 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id S262007AbTEEHaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 03:30:21 -0400
Date: Mon, 5 May 2003 00:42:48 -0700
From: Richard Henderson <rth@twiddle.net>
To: David Mosberger-Tang <David.Mosberger@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix vsyscall unwind information
Message-ID: <20030505074248.GA7812@twiddle.net>
Mail-Followup-To: David Mosberger-Tang <David.Mosberger@acm.org>,
	linux-kernel@vger.kernel.org
References: <20030502004014$08e2@gated-at.bofh.it> <20030503210015$292c@gated-at.bofh.it> <20030504063010$279f@gated-at.bofh.it> <ugade16g78.fsf@panda.mostang.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ugade16g78.fsf@panda.mostang.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 11:49:31PM -0700, David Mosberger-Tang wrote:
> Is there a marker or some other way to identify the sigreturn as such?

No.

> If not, could one be added?

Why?  Certainly it isn't needed for x86.


r~
