Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268657AbUIGVRI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268657AbUIGVRI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Sep 2004 17:17:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268679AbUIGVQC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Sep 2004 17:16:02 -0400
Received: from cantor.suse.de ([195.135.220.2]:50123 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268657AbUIGVKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Sep 2004 17:10:22 -0400
Date: Tue, 7 Sep 2004 23:10:20 +0200
From: Olaf Hering <olh@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] update arch/ppc/defconfig
Message-ID: <20040907211020.GA14828@suse.de>
References: <20040907200013.GA14330@suse.de> <20040907202218.GH20951@smtp.west.cox.net> <20040907204135.GA14700@suse.de> <20040907210659.GI20951@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040907210659.GI20951@smtp.west.cox.net>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Tue, Sep 07, Tom Rini wrote:

> Doesn't compile or doesn't work on your prep board?

Some PCI stuff goes wrong, its unrelated to cirrusfb.

> > having sysrq is always a win.
> 
> Only when you can see the output.  Or do you mean SysRq-S-U-B? :)

echo t > /proc/sysrq-trigger

Anyway, just send something to akpm that doesnt require interaction during
make oldconfig

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
