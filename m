Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751349AbWF3Ak7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbWF3Ak7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 20:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWF3Ak7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 20:40:59 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:65463 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751349AbWF3Ak6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 20:40:58 -0400
Date: Thu, 29 Jun 2006 17:40:36 -0700
From: Paul Jackson <pj@sgi.com>
To: Shailabh Nagar <nagar@watson.ibm.com>
Cc: akpm@osdl.org, Valdis.Kletnieks@vt.edu, jlan@engr.sgi.com,
       balbir@in.ibm.com, csturtiv@sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629174036.2e592a5b.pj@sgi.com>
In-Reply-To: <44A46D3B.6060703@watson.ibm.com>
References: <44892610.6040001@watson.ibm.com>
	<20060623141926.b28a5fc0.akpm@osdl.org>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<20060629112642.66f35dd5.pj@sgi.com>
	<44A426DC.9090009@watson.ibm.com>
	<20060629124148.48d4c9ad.pj@sgi.com>
	<44A4492E.6090307@watson.ibm.com>
	<20060629152319.cfffe0d6.pj@sgi.com>
	<44A46D3B.6060703@watson.ibm.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> Nope...as long as there are users who are using cpusets ONLY as a means 
> of reducing sockets to listen to, timestamps will be needed.

Could you take one more stab at explaining this.

It made no sense to me this time around.  Sorry.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
