Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbTJBQnn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 12:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263418AbTJBQnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 12:43:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:57497 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263415AbTJBQnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 12:43:42 -0400
Subject: Re: 2.6.0-test6-mm2 (compile statistics)
From: John Cherry <cherry@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       linux-mm@kvack.org
In-Reply-To: <20031002022341.797361bc.akpm@osdl.org>
References: <20031002022341.797361bc.akpm@osdl.org>
Content-Type: text/plain
Organization: 
Message-Id: <1065113020.15172.35.camel@cherrytest.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 02 Oct 2003 09:43:40 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I added the mm builds to the compile regressions.  The full set of
compile data can be found at:

   http://developer.osdl.org/cherry/compile/mm/index.html

For the -test6 mm builds, the compile regress summary is...

Kernel version: 2.6.0-test6-mm2
Kernel build: 
   Making bzImage (defconfig): 0 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allyesconfig): 179 warnings, 13 errors
   Making modules (allyesconfig): 9 warnings, 0 errors
   Making bzImage (allmodconfig): 3 warnings, 0 errors
   Making modules (allmodconfig): 252 warnings, 4 errors

Kernel version: 2.6.0-test6-mm1
Kernel build: 
   Making bzImage (defconfig): 0 warnings, 0 errors
   Making modules (defconfig): 0 warnings, 0 errors
   Making bzImage (allyesconfig): 179 warnings, 11 errors
   Making modules (allyesconfig): 9 warnings, 0 errors
   Making bzImage (allmodconfig): 3 warnings, 0 errors
   Making modules (allmodconfig): 252 warnings, 2 errors

John

