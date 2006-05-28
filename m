Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750772AbWE1PiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWE1PiT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 11:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWE1PiT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 11:38:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49100 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750772AbWE1PiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 11:38:18 -0400
To: Tony Griffiths <tonyg@agile.tv>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: PROBLEM: /proc (procfs) task exit race condition causes a
 kernel crash
References: <44764F35.9050002@agile.tv>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 28 May 2006 09:37:13 -0600
In-Reply-To: <44764F35.9050002@agile.tv> (Tony Griffiths's message of "Fri,
 26 May 2006 10:43:33 +1000")
Message-ID: <m1irnq6tzq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have tried to reproduce this.  The circumstances weren't the most
controlled but they did overlap with what you described and I haven't seen
anything.

So I am guessing that you are having memory corruption from some source.
Either bad ram or a bad module.

I'm off on vacation for a week, so I won't be able to follow up.


Eric
