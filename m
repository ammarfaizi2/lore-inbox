Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268452AbTGLUST (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 16:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268473AbTGLUSS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 16:18:18 -0400
Received: from smtp1.clear.net.nz ([203.97.33.27]:23801 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S268452AbTGLUSP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 16:18:15 -0400
Date: Sun, 13 Jul 2003 08:22:05 +1200
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [Swsusp-devel] Re: Thoughts wanted on merging Software Suspend
	enhancements
In-reply-to: <20030712201525.GB446@elf.ucw.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1058041325.2007.4.camel@laptop-linux>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.2
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <1057963547.3207.22.camel@laptop-linux>
 <20030712140057.GC284@elf.ucw.cz> <1058021722.1687.16.camel@laptop-linux>
 <20030712153719.GA206@elf.ucw.cz> <1058038701.2482.25.camel@laptop-linux>
 <20030712201525.GB446@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Sun, 2003-07-13 at 08:15, Pavel Machek wrote:
> No, you don't understand.
> 
> Magic SysRq is well known mechanism for torturing running
> kernel. Kernel hackers have it enabled, security-consious people have
> it disabled, and it is /proc-tweakable. It also works in cases like
> "the only keyboard on serial terminal", etc. 

Ah okay. So the security by obscurity bit was wrong, but the general
idea of SysRq-Esc was right?

Regards,

Nigel

-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

You see, at just the right time, when we were still powerless,
Christ died for the ungodly.
	-- Romans 5:6, NIV.

