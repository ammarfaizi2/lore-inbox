Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268681AbUILLoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268681AbUILLoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 07:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268719AbUILLlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 07:41:55 -0400
Received: from cantor.suse.de ([195.135.220.2]:60881 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268681AbUILLjl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 07:39:41 -0400
Message-ID: <41443571.6090303@suse.de>
Date: Sun, 12 Sep 2004 13:39:29 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stefan Schweizer <sschweizer@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: FYI: my current bigdiff
References: <20040909134421.GA12204@elf.ucw.cz>	 <e796392204091201541320aa31@mail.gmail.com> <414415AA.8050503@suse.de> <e7963922040912023274749b14@mail.gmail.com>
In-Reply-To: <e7963922040912023274749b14@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Schweizer wrote:

> LeaveXbeforesuspend just does a chvt15 before and chvt 7 after suspend.

swsusp does a chvt to a console so this should not be needed.

	Stefan
