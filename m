Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUJYXgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUJYXgV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 19:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUJYXc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 19:32:59 -0400
Received: (root@vger.kernel.org) by vger.kernel.org id S261949AbUJYXQH
	(ORCPT <rfc822;linux-kernel>); Mon, 25 Oct 2004 19:16:07 -0400
Date: Mon, 25 Oct 2004 19:16:06 -0400
From: Matti Aarnio <postmaster@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-smp@vger.kernel.org
Subject: Sorry about that strange stuff.. (in VGER's lists)
Message-ID: <20041025191606.A8657@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

.. but you are talking so much, that I have to figure out how to
speed processing up in present system by a factor of 10. (At least.)
I got to 70% mark with simple '-pg' profiling, but that is not enough,
and  to understand deep secrets of the MTA system's CPU-cycle
expenditure, I need to do some additional instrumenting.

Something went wrong in that stuff, and it is my turn to fetch
a brown paper bag...  I realized it happened, and have now stopped
the system for a moment.  The garbagled messages (most of them,
anyway) will be reprocessed without that bug.  It will also mean,
that you may get some messages (quite a lot, likely) twice.  None
should be older than 2-3 days.

Oops..  And back to debug.

/Matti Aarnio
