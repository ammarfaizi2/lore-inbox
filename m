Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261929AbTLLUYD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 15:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbTLLUYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 15:24:03 -0500
Received: from gprs149-168.eurotel.cz ([160.218.149.168]:9344 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261929AbTLLUYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 15:24:01 -0500
Date: Fri, 12 Dec 2003 20:22:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Michael Frank <mhf@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: Can swsusp 2.0 be merged into the 2.4 tree
Message-ID: <20031212192252.GA465@elf.ucw.cz>
References: <200312110537.17496.mhf@linuxmail.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312110537.17496.mhf@linuxmail.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> swsusp is useful feature also for 2.4. Could this please be merged.

2.4 has no driver model => swsusp for 2.4 is a hack. Its nice and
working, but it is still a hack.
							Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
