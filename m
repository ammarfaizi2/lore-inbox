Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267526AbUHJRVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267526AbUHJRVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 13:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267480AbUHJRRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 13:17:13 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:11422 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S267578AbUHJRQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 13:16:50 -0400
Subject: Re: [PATCH] BSD Secure Levels LSM (1/3)
From: Lee Revell <rlrevell@joe-job.com>
To: Michael Halcrow <lkml@halcrow.us>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20040810151420.GA4993@halcrow.us>
References: <20040810151420.GA4993@halcrow.us>
Content-Type: text/plain
Message-Id: <1092158224.3290.9.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 13:17:04 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-10 at 11:14, Michael Halcrow wrote:

> This particular patch adds a set of hooks that are necessary to catch
> attempts to decrement the system time.

Argh, IMHO this was the most annoying thing about adminning BSD/OS, if
the clock got ahead somehow you needed to down the thing to fix it.

Of course I am sure there are plenty of good reasons for this
functionality, I just would not want that one.

Lee

