Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263274AbTJBGw3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 02:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263271AbTJBGw2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 02:52:28 -0400
Received: from jupiter.loonybin.net ([208.248.0.98]:17937 "EHLO
	jupiter.loonybin.net") by vger.kernel.org with ESMTP
	id S263274AbTJBGw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 02:52:28 -0400
Date: Thu, 2 Oct 2003 01:52:18 -0500
From: Zinx Verituse <zinx@epicsol.org>
To: linux-kernel@vger.kernel.org
Subject: sg-style ATAPI commands in 2.6
Message-ID: <20031002065218.GA32246@bliss>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I haven't found much information on the raw ATAPI command
interface provided in Linux 2.6, but from what I can tell
it can understand the sg3 interface.

However, I can't open the device read-write, so mmap'd IO
is impossible, and unless it's currently horribly insecure,
I can't write CDs anyway.

I was just wondering what the desired behavior is, if there's
a different style interface I'm supposed to use, etc.

-- 
Zinx Verituse
