Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268072AbUHXQD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268072AbUHXQD1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 12:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268088AbUHXQD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 12:03:27 -0400
Received: from p508B6A77.dip.t-dialin.net ([80.139.106.119]:56393 "EHLO
	mail.linux-mips.net") by vger.kernel.org with ESMTP id S268072AbUHXQDS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 12:03:18 -0400
Date: Tue, 24 Aug 2004 18:03:04 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Valdis.Kletnieks@vt.edu
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] 2.6.9-rc1 - #ifdef cleanip for MIPS
Message-ID: <20040824160304.GA23826@linux-mips.org>
References: <200408241352.i7ODqf73026463@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408241352.i7ODqf73026463@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 09:52:41AM -0400, Valdis.Kletnieks@vt.edu wrote:

> Cleaning up some #if to use #ifdef instead, to make life safer for compiling
> with -Wundef.

Thanks, applied.

  Ralf
