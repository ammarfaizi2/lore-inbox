Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965092AbVKHMDV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965092AbVKHMDV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 07:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKHMDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 07:03:21 -0500
Received: from main.gmane.org ([80.91.229.2]:26030 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S965092AbVKHMDU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 07:03:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Dick <dm@chello.nl>
Subject: Re: SIGALRM ignored
Date: Tue, 8 Nov 2005 12:00:01 +0000 (UTC)
Message-ID: <loom.20051108T124813-159@post.gmane.org>
References: <loom.20051107T183059-826@post.gmane.org> <20051107160332.0efdf310.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 81.58.57.243 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051003 Firefox/1.0.7)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj <at> sgi.com> writes:
> This is unlikely to be a Linux kernel internal development
> issue, which is what this "linux-kernel <at> vger.kernel.org"
> list is focused on.  

Yesterday I found the following issue:
http://www.vttoth.com/sigalrm.htm

which is kernel related, I will try to recompile the kernel for MPENTIUM4 and
see if it helps.

Does someone know a debugging technique to see whats happening?

Thanks,
Dick

