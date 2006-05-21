Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932356AbWEUSSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932356AbWEUSSL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 14:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932403AbWEUSSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 14:18:11 -0400
Received: from smtp109.sbc.mail.mud.yahoo.com ([68.142.198.208]:57512 "HELO
	smtp109.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932356AbWEUSSK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 14:18:10 -0400
Date: Sun, 21 May 2006 11:18:04 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: + x86-move-vsyscall-page-out-of-fixmap-above-stack-tidy.patch added to -mm tree
Message-ID: <20060521181804.GA361@taniwha.stupidest.org>
References: <200605210951.k4L9pwHq023019@shell0.pdx.osdl.net> <20060521110609.GA8322@taniwha.stupidest.org> <20060521050951.027b9dab.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060521050951.027b9dab.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 05:09:51AM -0700, Andrew Morton wrote:

> Because it's cleaner and clearer

some would disagree

> and because Linus said.

ok, sure, that works (i don't personally agree, but if there is
contention it's best that someone just stands up and says "because i
said so")

> One is an assignment and the other is a test.  These have nothing to
> do with each other.

should there be a comment in codingstyle about this then perhaps?
