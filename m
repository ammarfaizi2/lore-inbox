Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbTIGUiN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 16:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbTIGUiN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 16:38:13 -0400
Received: from b0jm34bky18he.bc.hsia.telus.net ([64.180.152.77]:59148 "EHLO
	antichrist") by vger.kernel.org with ESMTP id S261353AbTIGUiL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 16:38:11 -0400
Date: Sun, 7 Sep 2003 13:37:23 -0700
From: carbonated beverage <ramune@net-ronin.org>
To: linux-kernel@vger.kernel.org
Subject: Re: cpu not being found by 2.6.0-test4, input event bug too
Message-ID: <20030907203723.GA10617@net-ronin.org>
References: <20030905032100.GA32489@net-ronin.org> <20030905101403.GA1026@net-ronin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905101403.GA1026@net-ronin.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tried an older kernel (2.5.6x-series) and the event input kernel log flood
is happening there, too.

Can't really test for SMP, etc. as -test3 was the first kernel I tried since
2.5.4x that booted properly on this system, and didn't panic quickly on
various stuff.  I can try a binary search across kernel versions, if I knew
what to test for.

Anyone have an idea?

-- DN
Daniel
