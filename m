Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750837AbWCADUu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750837AbWCADUu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750715AbWCADUu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:20:50 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:130 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750837AbWCADUt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:20:49 -0500
Date: Tue, 28 Feb 2006 19:20:38 -0800
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: akpm@osdl.org, laurent.riffard@free.fr, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, rjw@sisk.pl, mbligh@mbligh.org,
       clameter@engr.sgi.com, ebiederm@xmission.com
Subject: Re: 2.6.16-rc5-mm1
Message-Id: <20060228192038.38d5ec69.pj@sgi.com>
In-Reply-To: <20060228190535.41a8c697.pj@sgi.com>
References: <20060228042439.43e6ef41.akpm@osdl.org>
	<9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	<4404CE39.6000109@liberouter.org>
	<9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	<4404DA29.7070902@free.fr>
	<20060228162157.0ed55ce6.akpm@osdl.org>
	<20060228190535.41a8c697.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I might be confused in what patches I'm running, but I believe that
>     I am getting these permission denied errors with just the patches:
> 
>     > trivial-cleanup-to-proc_check_chroot.patch
>     > proc-fix-the-inode-number-on-proc-pid-fd.patch

drat - I was off by one in my reporting.

I'll try to get my act together before saying more.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
