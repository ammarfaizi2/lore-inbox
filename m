Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261694AbUKIVM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261694AbUKIVM4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 16:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261693AbUKIVMb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 16:12:31 -0500
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:28555 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261691AbUKIVMV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 16:12:21 -0500
Date: Tue, 9 Nov 2004 13:12:01 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ppc64: Bump MAX_HWIFS in IDE code
Message-ID: <20041109211201.GA8998@taniwha.stupidest.org>
References: <20041109203028.GA26806@krispykreme.ozlabs.ibm.com> <20041109125507.4bc49b3c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041109125507.4bc49b3c.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 09, 2004 at 12:55:07PM -0800, Andrew Morton wrote:

> hrmph.  That costs 50kbytes, excluding ide-tape.  It's worth a
> config variable, I think.

this come up from time to time, and i wonder why it can't be dynamic?
