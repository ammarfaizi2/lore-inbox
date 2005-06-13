Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261508AbVFMLVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261508AbVFMLVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 07:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVFMLVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 07:21:34 -0400
Received: from one.firstfloor.org ([213.235.205.2]:58852 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261508AbVFMLV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 07:21:29 -0400
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] blkstat
References: <42AD55FA.50109@yahoo.com.au>
From: Andi Kleen <ak@muc.de>
Date: Mon, 13 Jun 2005 13:21:28 +0200
In-Reply-To: <42AD55FA.50109@yahoo.com.au> (Nick Piggin's message of "Mon,
 13 Jun 2005 19:46:34 +1000")
Message-ID: <m1wtoybiyv.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin <nickpiggin@yahoo.com.au> writes:

> I have made a simple tool to measure idle and busy time for
> block devices.

It would be better to put the new statistic into iostat/sard
instead of requiring new tools. Then eventually it would all
end up in distributions too and could be easily used everywhere.

-Andi
