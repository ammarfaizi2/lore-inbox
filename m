Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTEMQJK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 12:09:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTEMQJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 12:09:10 -0400
Received: from pat.uio.no ([129.240.130.16]:15603 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262109AbTEMQIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 12:08:04 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16065.6995.336780.264133@charged.uio.no>
Date: Tue, 13 May 2003 18:20:35 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@digeo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6 must-fix list, v2
In-Reply-To: <1052838378.463.41.camel@dhcp22.swansea.linux.org.uk>
References: <20030512155417.67a9fdec.akpm@digeo.com>
	<20030512155511.21fb1652.akpm@digeo.com>
	<1052834227.432.30.camel@dhcp22.swansea.linux.org.uk>
	<shsy91aonlt.fsf@charged.uio.no>
	<1052838378.463.41.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: VM 7.07 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
X-MailScanner-Information: Please contact postmaster@uio.no for more information
X-UiO-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

     > Are all of Steve's fixes for the NFS client from 2.4 propogated
     > into 2.5 now then ?

Which ones? Are you talking about the mmap() problem that he reported?
We're still looking for a solution to that. I'm not convinced that his
fix is appropriate as it appears to me just to be playing with the
timing of the symptoms.

Unless he's hoarding something, then most of the other 2.4 fixes
should be stuff he got off Chuck and me, so those are already in...

Cheers,
  Trond
