Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbTJDWpV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Oct 2003 18:45:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262796AbTJDWpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Oct 2003 18:45:21 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:470 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262791AbTJDWpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Oct 2003 18:45:19 -0400
To: Andy Lutomirski <luto@stanford.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test6: Filesystem capabilities 0.15
References: <fa.ign8c9e.3g8vr4@ifi.uio.no> <3F7E743A.9010601@stanford.edu>
From: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Date: Sun, 05 Oct 2003 00:45:07 +0200
Message-ID: <87r81sbp1o.fsf@goat.bogus.local>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

Andy Lutomirski <luto@stanford.edu> writes:

> I have an alternate patch, implementing file capabilities using
> xattrs.
[...]
> The patch and user tools are at http://www.stanford.edu/~luto/linux-fscap/
> (Apply the cap- patches in order.  Patches are against 2.6.0-test6 vanilla.)

I glanced over it and it looks interesting. Thanks for this
alternative view.

> Olaf -- what do you think?  (I like your CAP_SETFCAP addition -- I may
> add it to my patch.

This is not my invention. It is part of the POSIX standard, see
<http://wt.xpilot.org/publications/posix.1e/> and
<http://wt.xpilot.org/publications/posix.1e/download.html>

Regards, Olaf.
