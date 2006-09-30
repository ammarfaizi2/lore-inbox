Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751966AbWI3VrH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751966AbWI3VrH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 17:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751981AbWI3VrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 17:47:07 -0400
Received: from xenotime.net ([66.160.160.81]:34472 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1751966AbWI3VrD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 17:47:03 -0400
Date: Sat, 30 Sep 2006 14:48:30 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: Miguel Ojeda Sandonis <maxextreme@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.18 V6] drivers: add lcd display support
Message-Id: <20060930144830.eba63268.rdunlap@xenotime.net>
In-Reply-To: <451EE36C.5080002@s5r6.in-berlin.de>
References: <20060930132253.8ccaa0ad.maxextreme@gmail.com>
	<20060930123547.d055383f.rdunlap@xenotime.net>
	<451EE36C.5080002@s5r6.in-berlin.de>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Sep 2006 23:36:44 +0200 Stefan Richter wrote:

> ...
> >> patching file drivers/lcddisplay/cfag12864b.c
> ...
> 
> What does the D in LCD stand for? I suggest this is named
> drivers/lcdisplay/ instead.

Yes, someone else mentioned that too.
It does mean Display.
not a big deal to me in this age of acronyms.

---
~Randy
