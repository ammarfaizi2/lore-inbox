Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTKXWzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 17:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbTKXWzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 17:55:33 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:10763
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261473AbTKXWza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 17:55:30 -0500
Date: Mon, 24 Nov 2003 14:55:27 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: OOps! was: 2.6.0-test9-mm5
Message-ID: <20031124225527.GB1343@mis-mike-wstn.matchmail.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20031121121116.61db0160.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031121121116.61db0160.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm getting an oops on boot, right after serial is initialised.

Two things it says:
BAD EIP!
Trying to kill init!

Yes, I'm using preempt.  I'll try without, and see if that "fixes" the
problem, and try some other versions, since the last 2.6 booted on this
machine is 2.6.0-test6-mm4.

Mike
