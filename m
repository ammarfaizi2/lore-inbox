Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261353AbVC0VCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbVC0VCY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 16:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261555AbVC0VCY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 16:02:24 -0500
Received: from orb.pobox.com ([207.8.226.5]:27566 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S261353AbVC0VCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 16:02:22 -0500
Date: Sun, 27 Mar 2005 13:02:18 -0800
From: "Barry K. Nathan" <barryn@pobox.com>
To: Norberto Bensa <nbensa@gmx.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BK snapshots removed from kernel.org?
Message-ID: <20050327210218.GA1236@ip68-4-98-123.oc.oc.cox.net>
References: <200503271414.33415.nbensa@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503271414.33415.nbensa@gmx.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 02:14:33PM -0300, Norberto Bensa wrote:
[quote rewrapped to keep it within 80 columns]
> Why were snapshots (-bk) removed from www.kernel.org? I can't see any
> relevant post in LKML.

It happens whenever the kernel.org scripts get confused. It's happened
at least once before; this time I think it happened when the fixes
from 2.6.11.6 were merged into Linus's BK tree.

You can still get to the snapshots using this URL, but as I said, the
scripts are confused right now:
http://kernel.org/pub/linux/kernel/v2.6/snapshots/

-Barry K. Nathan <barryn@pobox.com>
