Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269935AbUJHMxn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269935AbUJHMxn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Oct 2004 08:53:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269956AbUJHMxn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Oct 2004 08:53:43 -0400
Received: from open.hands.com ([195.224.53.39]:40396 "EHLO open.hands.com")
	by vger.kernel.org with ESMTP id S269935AbUJHMxe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Oct 2004 08:53:34 -0400
Date: Fri, 8 Oct 2004 14:04:42 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: linux-kernel@vger.kernel.org
Subject: how do you call userspace syscalls (e.g. sys_rename) from inside kernel
Message-ID: <20041008130442.GE5551@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-hands-com-MailScanner-SpamScore: s
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

could someone kindly advise me on the location of some example code in
the kernel which calls one of the userspace system calls from inside the
kernel?

alternatively if this has never been considered before, please could
someone advise me as to how it might be achieved?

thank you,

l.

[p.s. i found asm/unistd.h, i found the macros syscall012345
etc., i believe i don't quite understand what these are for, and
may be on the wrong track.]

-- 
--
Truth, honesty and respect are rare commodities that all spring from
the same well: Love.  If you love yourself and everyone and everything
around you, funnily and coincidentally enough, life gets a lot better.
--
<a href="http://lkcl.net">      lkcl.net      </a> <br />
<a href="mailto:lkcl@lkcl.net"> lkcl@lkcl.net </a> <br />

