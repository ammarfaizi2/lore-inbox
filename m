Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261359AbTDCRS5 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261489AbTDCRS5 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:18:57 -0500
Received: from pat.uio.no ([129.240.130.16]:30664 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261359AbTDCRRF 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Apr 2003 12:17:05 -0500
To: Stacy Woods <stacyw@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Bugs sitting in the RESOLVED state for more than 2 weeks
References: <3E8C578E.8000202@us.ibm.com>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 03 Apr 2003 19:28:27 +0200
In-Reply-To: <3E8C578E.8000202@us.ibm.com>
Message-ID: <shs1y0jlcck.fsf@charged.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Stacy Woods <stacyw@us.ibm.com> writes:

     >   24 File Sys NFS khoa@us.ibm.com
     > statfs returns incorrect number fo blocks

This patch is *not* NFS specific. It needs to be pushed to
linux-fsdevel and linux-kernel for more general review.

Cheers,
  Trond
