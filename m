Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbTIDSKQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 14:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265397AbTIDSKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 14:10:15 -0400
Received: from 224.Red-217-125-129.pooles.rima-tde.net ([217.125.129.224]:55020
	"HELO cocodriloo.com") by vger.kernel.org with SMTP id S265401AbTIDSIR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 14:08:17 -0400
Date: Thu, 4 Sep 2003 17:38:31 +0200
From: Antonio Vargas <wind@cocodriloo.com>
To: Dave Olien <dmo@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: How to get a backtrace (sysrq-t) on a specific task?
Message-ID: <20030904153831.GG2359@wind.cocodriloo.com>
References: <20030904171626.GA26054@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030904171626.GA26054@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 10:16:26AM -0700, Dave Olien wrote:
> 
> I'm seeing a mkfs.ext2 that never completes under 2.6.0-test4-mm5.
> I ran 4 mkfs.ext2's concurrntly, each on a seperate partition on the
> same disk.  Three of the completed.  Here's the sysrq stack trace from
> the one that didn't.

How do you do a sysrq-T on a specific task???

[snip]

Greets, Antonio.
