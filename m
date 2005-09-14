Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932732AbVINUzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932732AbVINUzl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 16:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbVINUzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 16:55:41 -0400
Received: from mxsf09.cluster1.charter.net ([209.225.28.209]:15785 "EHLO
	mxsf09.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S932732AbVINUzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 16:55:40 -0400
X-IronPort-AV: i="3.97,110,1125892800"; 
   d="scan'208"; a="1527044395:sNHT14313512"
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17192.36421.885570.599596@smtp.charter.net>
Date: Wed, 14 Sep 2005 16:55:33 -0400
From: "John Stoffel" <john@stoffel.org>
To: Phil Dier <phil@icglink.com>
Cc: linux-kernel@vger.kernel.org, ziggy <ziggy@icglink.com>,
       Jack Massari <jack@icglink.com>, Scott Holdren <scott@icglink.com>
Subject: Re: Slow I/O with SMP, Fusion-MPT and u160 SCSI JBOD
In-Reply-To: <20050914150109.232c6765.phil@icglink.com>
References: <20050914150109.232c6765.phil@icglink.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Phil,

What happens if you pull 1gb or 2gb of memory from your box?  Running
a news feed shouldn't be memory intensive and maybe you've run into a
low-mem vs. high-mem issue.  It would be an interesting test in any
case.

John
