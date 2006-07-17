Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751038AbWGQWgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751038AbWGQWgJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751096AbWGQWgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:36:08 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:24315 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751038AbWGQWgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:36:07 -0400
Date: Tue, 18 Jul 2006 00:36:08 +0200
From: Voluspa <lista1@comhem.se>
To: nagar@watson.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Patch 3/3] delay accounting: temporarily enable by default
Message-Id: <20060718003608.89867837.lista1@comhem.se>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-07-17 21:56:03 Shailabh Nagar wrote:
> Enable delay accounting by default so that feature gets coverage testing
> without requiring special measures/

It's bloody hot in Sweden right now, and this is no Cool Aid.

> Earlier, it was off by default and had to be enabled via a boot time
> param. This patch reverses the default behaviour to improve coverage
> testing.

If it hasn't already received enough testing, what's it doing here?

> It can be removed late in the kernel development cycle if its
> believed users shouldn't have to incur any cost if they don't want
> delay accounting.

We bloody well shouldn't have.

> Or it can be retained forever if the utility of the
> stats is deemed common enough to warrant keeping the feature on.

It bloody well shouldn't be.

Corporate bloat should be hidden and buried below 45 metres of
disgusting cow dung so that innocent users don't get smelled up.

Mvh
Mats Johannesson
