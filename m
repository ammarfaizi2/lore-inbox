Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130505AbRBVQlj>; Thu, 22 Feb 2001 11:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130482AbRBVQlb>; Thu, 22 Feb 2001 11:41:31 -0500
Received: from gateway.macroscoop.nl ([195.193.201.73]:7184 "EHLO
	mondriaan.macroscoop.nl") by vger.kernel.org with ESMTP
	id <S130295AbRBVQlM> convert rfc822-to-8bit; Thu, 22 Feb 2001 11:41:12 -0500
From: Pim Zandbergen <P.Zandbergen@macroscoop.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IBM ServeRAID driver version 4.50 update
Date: Thu, 22 Feb 2001 17:41:10 +0100
Organization: Macroscoop BV
Message-ID: <pvea9t00nmbesoge67d7ka9e4bj1sgr0mi@4ax.com>
In-Reply-To: <fa.n6467uv.1n32a1k@ifi.uio.no> <NCBBJAAFLJPMOAOEDDEDKENECGAA.P.Zandbergen@macroscoop.nl> <fa.gqi2nnv.1sgeept@ifi.uio.no>
In-Reply-To: <fa.gqi2nnv.1sgeept@ifi.uio.no>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>4.50 has the same Linux kernel code as the stuff merged. The newer stuff is
>firmware only it seems

The Linux kernel code comes with version 4.20. I count 128 lines of
"diff -u" output on ips.c and 44 on ips.h. It also looks like both
versions have different patches applied to them.

