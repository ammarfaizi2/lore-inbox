Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbUB0SrZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:47:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262895AbUB0SqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:46:24 -0500
Received: from hera.kernel.org ([63.209.29.2]:62413 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262944AbUB0SoF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:44:05 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: Intel vs AMD64
Date: Fri, 27 Feb 2004 18:44:00 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1o35g$ii7$1@terminus.zytor.com>
References: <7F740D512C7C1046AB53446D37200173EA28A5@scsmsx402.sc.intel.com> <20040226133959.GA19254@dingdong.cryptoapps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077907440 19016 63.209.29.3 (27 Feb 2004 18:44:00 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 27 Feb 2004 18:44:00 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040226133959.GA19254@dingdong.cryptoapps.com>
By author:    Chris Wedgwood <cw@f00f.org>
In newsgroup: linux.dev.kernel
> 
> Not that it really matters that much --- but I'm curious to know why
> Intel made this decision?
> 
> It seems really dumb to make such differences when Intel is already
> sorely lagging behind their competitor here, I would think given the
> circumstances Intel would try to be as compatible as possible on all
> fronts.

This, and a whole bunch of the other "IA-32e differences", I think
really should be classified as "Intel bugs."

They really have more the flavour of errata than anything else...

	-hpa
