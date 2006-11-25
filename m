Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967197AbWKYUr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967197AbWKYUr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 15:47:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967198AbWKYUr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 15:47:59 -0500
Received: from 1wt.eu ([62.212.114.60]:45828 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S967197AbWKYUr7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 15:47:59 -0500
Date: Sat, 25 Nov 2006 22:38:11 +0100
From: Willy Tarreau <w@1wt.eu>
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH-2.4] jfs: incorrect use of "&&" instead of "&"
Message-ID: <20061125213811.GA6118@1wt.eu>
References: <20061125212440.GA5930@1wt.eu> <1164487421.16418.1.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164487421.16418.1.camel@kleikamp.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2006 at 02:43:41PM -0600, Dave Kleikamp wrote:
> On Sat, 2006-11-25 at 22:24 +0100, Willy Tarreau wrote:
> > Hi Dave,
> > 
> > I'm about to merge this fix in 2.4. It's already in 2.6 BTW.
> > Do you have any objection ?
> 
> No objection.

Thanks, applied.
Willy

