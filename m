Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbUDMHjH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 03:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUDMHjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 03:39:07 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:25762 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S261369AbUDMHjE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 03:39:04 -0400
Date: Tue, 13 Apr 2004 01:38:50 -0600
From: Kurt Fitzner <kfitzner@excelcia.org>
Subject: Re: 2.6.5-mm5
In-reply-to: <20040412221717.782a4b97.akpm@osdl.org>
To: linux-kernel@vger.kernel.org
Message-id: <407B990A.8050407@excelcia.org>
MIME-version: 1.0
Content-type: text/plain; format=flowed; charset=us-ascii
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040402)
X-Enigmail-Version: 0.83.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
References: <20040412221717.782a4b97.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.5/2.6.5-mm5/
> 
> - More CPU scheduler work.  Hopefully this kernel will now address the
>   regressions that a few people have noted on certain workloads.  We appear to
>   be getting close.

Regressions... from the context, I'm assuming you're not talking
regression errors here?  I'm assuming these are performance issues?  I
see a 3.5% drop in compiling speed between 2.4.24 and 2.6.5 on a dual
Athlon workstation.  I'll test this kernel happily if the scheduler
tweaks are intended to address this.

