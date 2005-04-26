Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261380AbVDZHF0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261380AbVDZHF0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 03:05:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261379AbVDZHD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 03:03:27 -0400
Received: from smtpauth09.mail.atl.earthlink.net ([209.86.89.69]:49129 "EHLO
	smtpauth09.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S261373AbVDZHCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 03:02:36 -0400
Message-ID: <426DE78A.3050508@mindspring.com>
Date: Tue, 26 Apr 2005 00:02:34 -0700
From: Philip Pokorny <ppokorny@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pasky@ucw.cz, git@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] Cogito-0.8 (former git-pasky, big changes!)
References: <20050426032422.GQ13467@pasky.ji.cz>
In-Reply-To: <20050426032422.GQ13467@pasky.ji.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: 662518af21fc89ef9c7f779228e2f6aeda0071232e20db4dc8f27ea7dc642ff4913448491e92a054350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.164.169.208
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Petr Baudis wrote:

> the history changed again (hopefully the
>last time?) because of fixing dates of some old commits.
>

Looks like the git-pasky-0.7 tags (and friends) are now dead links. For 
example:

[philip@xray cogito]$ cg-mkpatch git-pasky-0.7:HEAD
.git/objects/c8/3b95297c2a6336c2007548f909769e0862b509: No such file or 
directory
fatal: cat-file c83b95297c2a6336c2007548f909769e0862b509: bad file
Invalid id: c83b95297c2a6336c2007548f909769e0862b509


Is there any way to recover that, or has the timeline been irrevocably 
altered, and we're all now doomed to meet bastard daughters of long dead 
crew members? [grin]...

:v)

Actually, I really liked that Enterprise-C episode...
