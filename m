Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271850AbTG2Wr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 18:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272134AbTG2Wr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 18:47:26 -0400
Received: from p68.rivermarket.wintek.com ([208.13.56.68]:35823 "EHLO dust")
	by vger.kernel.org with ESMTP id S271850AbTG2Wr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 18:47:26 -0400
Date: Tue, 29 Jul 2003 17:51:05 -0500 (EST)
From: Alex Goddard <agoddard@purdue.edu>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cant open a console in X
In-Reply-To: <3F26D9B3.2050006@mscc.huji.ac.il>
Message-ID: <Pine.LNX.4.56.0307291750210.3692@dust>
References: <3F26D9B3.2050006@mscc.huji.ac.il>
X-GPG-PUBLIC_KEY: N/a
X-GPG-FINGERPRINT: BCBC 0868 DB78 22F3 A657 785D 6E3B 7ACB 584E B835
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Voicu Liviu wrote:

> Hi, I just compiled kernel 2.6-beta2 and I can not open a console in 
> while running XFree.
> Any idea?

Make sure you're mounting devpts manually by adding an entry for it in 
your /etc/fstab.

-- 
Alex Goddard
agoddard@purdue.edu
