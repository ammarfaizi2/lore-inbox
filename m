Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWDFWiZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWDFWiZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Apr 2006 18:38:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWDFWiZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Apr 2006 18:38:25 -0400
Received: from xenotime.net ([66.160.160.81]:42158 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932188AbWDFWiY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Apr 2006 18:38:24 -0400
Date: Thu, 6 Apr 2006 15:40:40 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "John Rigby" <jcrigby@gmail.com>
Cc: zippel@linux-m68k.org, sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Allow menuconfig to cycle through choices
Message-Id: <20060406154040.c5430029.rdunlap@xenotime.net>
In-Reply-To: <4b73d43f0604061358v1c619e21rc6f3af2cdc4545a3@mail.gmail.com>
References: <4b73d43f0604061338i1c5315f1t34761380b620fc57@mail.gmail.com>
	<4b73d43f0604061339n35a4d98ha08bf8d7fc0bef0b@mail.gmail.com>
	<4b73d43f0604061358v1c619e21rc6f3af2cdc4545a3@mail.gmail.com>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Apr 2006 14:58:34 -0600 John Rigby wrote:

> 
> 
Subject: [PATCH] Allow menuconfig to cycle through choices

Added cycling logic to dialog_checklist identical to what
dialog_menu already has.
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Hi,
Can you give an example of a checklist (aka radiolist in menuconfig)
where this change has an effect?

I expected Timer frequency (choosing between 100, 250, 1000 HZ) to
cycle, but it does not.  And I expected Default I/O scheduler
to cycle, but it does not.  So where can I look for a change
after applying this patch?

Thanks,
---
~Randy
