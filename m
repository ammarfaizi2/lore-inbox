Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261626AbVC2XS0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261626AbVC2XS0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:18:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261627AbVC2XS0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:18:26 -0500
Received: from pat.uio.no ([129.240.130.16]:5777 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261626AbVC2XSY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:18:24 -0500
Subject: Re: NFS client latencies
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112137487.5386.33.camel@mindpipe>
References: <1112137487.5386.33.camel@mindpipe>
Content-Type: text/plain
Date: Tue, 29 Mar 2005 18:18:03 -0500
Message-Id: <1112138283.11346.2.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.542, required 12,
	autolearn=disabled, AWL 1.41, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 29.03.2005 Klokka 18:04 (-0500) skreiv Lee Revell:
> I am seeing long latencies in the NFS client code.  Attached is a ~1.9
> ms latency trace.

What kind of workload are you using to produce these numbers?

Cheers,
  Trond
-- 
Trond Myklebust <trond.myklebust@fys.uio.no>

