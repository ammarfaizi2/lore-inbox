Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261553AbVCNQYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261553AbVCNQYb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:24:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVCNQYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:24:31 -0500
Received: from fire.osdl.org ([65.172.181.4]:53180 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261553AbVCNQYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:24:25 -0500
Subject: Re: 2.6.11-mm3 (compile stats)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20050312034222.12a264c4.akpm@osdl.org>
References: <20050312034222.12a264c4.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 14 Mar 2005 08:25:55 -0800
Message-Id: <1110817555.20447.3.camel@cherrypit.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Compile Statistics
------------------
Build Tree: mm
Compiler: gcc 3.4.1
Detailed results: http://developer.osdl.org/cherry/compile/

Summary - 2.6.11-mm2 to 2.6.11-mm3
----------------------------------
Defconfig (bzImage): -2 warnings
Allnoconfig (bzImage): no change
Allyesconfig (bzImage): +54 warnings
Allyesconfig (modules): no change
Allmodconfig (bzImage): no change
Allmodconfig (modules: +52 warnings

Kernel            bzImage   bzImage  bzImage  modules  bzImage  modules
                (defconfig) (allno) (allyes) (allyes) (allmod) (allmod)
--------------- ---------- -------- -------- -------- -------- --------
<pointless and stupid compiler numbers omitted for your convenience.
See link above if interested in the detailed compile information.>

:)

John



