Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263101AbUCMO1W (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Mar 2004 09:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263102AbUCMO1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Mar 2004 09:27:22 -0500
Received: from boggle.pobox.com ([208.58.1.193]:42626 "EHLO boggle.pobox.com")
	by vger.kernel.org with ESMTP id S263101AbUCMO05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Mar 2004 09:26:57 -0500
Date: Sat, 13 Mar 2004 07:26:41 -0700
From: Paul Dickson <dickson@permanentmail.com>
To: John Cherry <cherry@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-rc2-mm1 (compile stats)
Message-Id: <20040313072641.612ed567.dickson@permanentmail.com>
In-Reply-To: <1078762814.10171.4.camel@cherrytest.pdx.osdl.net>
References: <20040307223221.0f2db02e.akpm@osdl.org>
	<1078762814.10171.4.camel@cherrytest.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Mar 2004 08:20:14 -0800, John Cherry wrote:

> Included with this report is a list of the current warnings from the
> 2.6.4-rc2-mm1 builds.
> 
> Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
> Warnings/Errors Summary
> 
> Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
>                 (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
> --------------- ---------- -------- -------- -------- -------- --------
> 2.6.3-rc2-mm1     1w/0e     5w/0e   146w/12e  11w/0e   3w/0e    147w/2e
> 2.6.3-rc1-mm2     1w/0e     5w/0e   144w/ 0e  11w/0e   3w/0e    145w/0e
> 2.6.3-rc1-mm1     1w/0e     5w/0e   147w/ 5e  11w/0e   3w/0e    147w/0e
> 2.6.3-mm4         1w/0e     5w/0e   146w/ 0e   7w/0e   3w/0e    142w/0e
> 2.6.3-mm3         1w/2e     5w/2e   146w/15e   7w/0e   3w/2e    144w/5e
> 2.6.3-mm2         1w/8e     5w/0e   140w/ 0e   7w/0e   3w/0e    138w/0e
> 2.6.3-mm1         1w/0e     5w/0e   143w/ 5e   7w/0e   3w/0e    141w/0e
> 2.6.3-rc3-mm1     1w/0e     0w/0e   144w/13e   7w/0e   3w/0e    142w/3e
> 2.6.3-rc2-mm1     1w/0e     0w/265e 144w/ 5e   7w/0e   3w/0e    145w/0e
> 2.6.3-rc1-mm1     1w/0e     0w/265e 141w/ 5e   7w/0e   3w/0e    143w/0e

The 2.6.4 stats are mislabeled 2.6.3...

	-Paul

