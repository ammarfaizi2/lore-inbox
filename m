Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263617AbUJ3Gpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263617AbUJ3Gpu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 02:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263620AbUJ3Gpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 02:45:50 -0400
Received: from cantor.suse.de ([195.135.220.2]:13999 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263617AbUJ3Gpq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 02:45:46 -0400
Date: Sat, 30 Oct 2004 08:45:45 +0200
From: Olaf Hering <olh@suse.de>
To: Dave Jones <davej@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Configurable Magic Sysrq
Message-ID: <20041030064545.GA27910@suse.de>
References: <20041029093941.GA2237@atrey.karlin.mff.cuni.cz> <20041029024651.1ebadf82.akpm@osdl.org> <20041029101758.GA7278@atrey.karlin.mff.cuni.cz> <20041029032420.327d65dd.akpm@osdl.org> <20041029200907.GB18508@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041029200907.GB18508@redhat.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Oct 29, Dave Jones wrote:

> On Fri, Oct 29, 2004 at 03:24:20AM -0700, Andrew Morton wrote:
>  > OK, fair enough.  I'll merge the patch if you talk suse into enabling
>  > sysrq-T and sysrq-P and sysrq-M by default ;)
>  
> you already have those available if /proc/sys/kernel/sysrq is 0.
> 
> alt-scrolllock / ctrl-scrolllock / shift-scrolllock.

How do I trigger that via serial/hvc?

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
