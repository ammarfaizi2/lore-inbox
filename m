Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268111AbUHYQMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268111AbUHYQMf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 12:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268098AbUHYQMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 12:12:35 -0400
Received: from krusty.dt.e-technik.Uni-Dortmund.DE ([129.217.163.1]:49845 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S268043AbUHYQMd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 12:12:33 -0400
Date: Wed, 25 Aug 2004 18:12:31 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-rc1
Message-ID: <20040825161231.GA28911@merlin.emma.line.org>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004, Linus Torvalds wrote:

>  tons of patches merged, with me being away for a week, and also the
> normal pent-up patch demand after any stable kernel. Special thanks as

For reasons I haven't yet fully understood, 2.6.9-rc1 appears to break
Amanda for me. amcheck passes, but amdump waits forever for data from
other machines while dumping. Older kernels appear to be fine.

Have there been relevant networking or security changes since 2.6.8.1?
