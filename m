Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266604AbUAWRIZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266605AbUAWRIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:08:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:49830 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266604AbUAWRIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:08:20 -0500
Subject: Re: 2.6.2-rc1-mm2 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20040123013740.58a6c1f9.akpm@osdl.org>
References: <20040123013740.58a6c1f9.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1074877697.25026.2.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 23 Jan 2004 09:08:17 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No change from 2.6.2-rc1-mm1.

Linux 2.6 (mm tree) Compile Statistics (gcc 3.2.2)
Warnings/Errors Summary

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
2.6.2-rc1-mm2     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.2-rc1-mm1     0w/0e     0w/264e 144w/ 5e  10w/0e   3w/0e    171w/0e
2.6.1-mm5         2w/5e     0w/264e 153w/11e  10w/0e   3w/0e    180w/0e
2.6.1-mm4         0w/821e   0w/264e 154w/ 5e   8w/1e   5w/0e    179w/0e
2.6.1-mm3         0w/0e     0w/0e   151w/ 5e  10w/0e   3w/0e    177w/0e
2.6.1-mm2         0w/0e     0w/0e   143w/ 5e  12w/0e   3w/0e    171w/0e
2.6.1-mm1         0w/0e     0w/0e   146w/ 9e  12w/0e   6w/0e    171w/0e
2.6.1-rc2-mm1     0w/0e     0w/0e   149w/ 0e  12w/0e   6w/0e    171w/4e
2.6.1-rc1-mm2     0w/0e     0w/0e   157w/15e  12w/0e   3w/0e    185w/4e
2.6.1-rc1-mm1     0w/0e     0w/0e   156w/10e  12w/0e   3w/0e    184w/2e
2.6.0-mm2         0w/0e     0w/0e   161w/ 0e  12w/0e   3w/0e    189w/0e
2.6.0-mm1         0w/0e     0w/0e   173w/ 0e  12w/0e   3w/0e    212w/0e

Web page with links to complete details:
   http://developer.osdl.org/cherry/compile/

John

