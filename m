Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263529AbTDTE71 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 00:59:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263530AbTDTE71
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 00:59:27 -0400
Received: from [66.212.224.118] ([66.212.224.118]:48133 "HELO
	hemi.commfireservices.com") by vger.kernel.org with SMTP
	id S263529AbTDTE71 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 00:59:27 -0400
Date: Sun, 20 Apr 2003 01:03:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Pascal Schmidt <der.eremit@email.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH 2.5] report unknown NMI reasons only once
In-Reply-To: <E1971af-0002vN-00@neptune.local>
Message-ID: <Pine.LNX.4.50.0304200058010.17265-100000@montezuma.mastecende.com>
References: <20030419183013$0e6c@gated-at.bofh.it> <20030419230019$7cdc@gated-at.bofh.it>
 <E1971af-0002vN-00@neptune.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Apr 2003, Pascal Schmidt wrote:

> Beats me as to what could be wrong. It's not a memory problem and the
> CPU does not overheat.
> 
> I'll go patch the kernel for my personal use then, but I'm not the only
> one seeing those messages without any system problems.

It's all fun and games until NMIs turn into MCEs...

 \|/ ____ \|/
"@'/ ,. \`@"
/_| \__/ |_\
   \__U_/
