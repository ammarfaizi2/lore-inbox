Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUL0WuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUL0WuG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 17:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261993AbUL0WuD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 17:50:03 -0500
Received: from ipcop.bitmover.com ([192.132.92.15]:11394 "EHLO
	work.bitmover.com") by vger.kernel.org with ESMTP id S261992AbUL0Wt7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 17:49:59 -0500
Date: Mon, 27 Dec 2004 14:49:58 -0800
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: [BK] mipsel-glibc20-linux?
Message-ID: <20041227224958.GB19391@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does anyone still care about BK binaries for Cobalt Qubes or other Linux
distros running in little endian on MIPS?  I'd just as soon drop support
for this, it takes a _long_ time to run build & regressions on this 
platform.  

We can keep it around and turn it on to do a build if someone needs it.
-- 
---
Larry McVoy                lm at bitmover.com           http://www.bitkeeper.com
