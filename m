Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262149AbUKQBJr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262149AbUKQBJr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 20:09:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262152AbUKQBJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 20:09:47 -0500
Received: from mail.suse.de ([195.135.220.2]:62858 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262149AbUKQBJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 20:09:45 -0500
Date: Wed, 17 Nov 2004 02:00:20 +0100
From: Andi Kleen <ak@suse.de>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Dropped patch: mm/mempolicy.c:sp_lookup()
Message-ID: <20041117010020.GF2392@wotan.suse.de>
References: <200411152318_MC3-1-8EBD-DEEE@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200411152318_MC3-1-8EBD-DEEE@compuserve.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 15, 2004 at 11:15:51PM -0500, Chuck Ebbert wrote:
> Andrea posted this one-liner a while ago as part of a larger patch.  He said
> it fixed return of the wrong policy in some conditions.  Was this a valid fix?

Yes it was.

-Andi
