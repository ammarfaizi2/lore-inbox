Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbUA0B1Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 20:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261193AbUA0B1Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 20:27:24 -0500
Received: from thunk.org ([140.239.227.29]:12957 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261188AbUA0B1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 20:27:23 -0500
Date: Mon, 26 Jan 2004 20:27:17 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: Andrew Morton <akpm@osdl.org>
Cc: campbell@accelinc.com, linux-kernel@vger.kernel.org
Subject: Re: 2.2 kernel and ext3 filesystems
Message-ID: <20040127012717.GA19704@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Andrew Morton <akpm@osdl.org>, campbell@accelinc.com,
	linux-kernel@vger.kernel.org
References: <20040124033208.GA4830@helium.inexs.com> <20040123215848.28dac746.akpm@osdl.org> <20040126145633.GA26983@helium.inexs.com> <20040126124141.6b6b84ba.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040126124141.6b6b84ba.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
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

On Mon, Jan 26, 2004 at 12:41:41PM -0800, Andrew Morton wrote:
> ext3 was originally written for 2.2 but was never merged into the
> mainstream kernel.   That happened in 2.4.15.

There were also some bug fixes that I'm pretty sure were never
backported into the 2.2 tree....

						- Ted

