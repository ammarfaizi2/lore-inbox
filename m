Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261438AbULIO1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261438AbULIO1M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 09:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbULIO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 09:27:12 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:50311 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261438AbULIO1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 09:27:09 -0500
To: Limin Gu <limin@dbear.engr.sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] jobfs - new virtual filesystem for job kernel/user
 interface
References: <200412082203.iB8M3Lk22375@dbear.engr.sgi.com>
From: Andreas Schwab <schwab@suse.de>
X-Yow: What's the MATTER Sid?..  Is your BEVERAGE unsatisfactory?
Date: Thu, 09 Dec 2004 15:27:08 +0100
In-Reply-To: <200412082203.iB8M3Lk22375@dbear.engr.sgi.com> (Limin Gu's
 message of "Wed, 8 Dec 2004 14:03:21 -0800 (PST)")
Message-ID: <jept1jmts3.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Limin Gu <limin@dbear.engr.sgi.com> writes:

> Hello,
>
> I am looking for your comments on the attached draft, it is the job patch 
> for 2.6.9. I have posted job patch for older kernel before, but in this patch
> I have replaced the /proc/job binary ioctl calls with a new small virtual 
> filesystem (jobfs).

Calling it "job" whould be quite confusing since it is already used to
refer to all processes in a process group in the shell.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
