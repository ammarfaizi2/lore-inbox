Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268119AbUIVXZl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268119AbUIVXZl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 19:25:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268120AbUIVXZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 19:25:41 -0400
Received: from rproxy.gmail.com ([64.233.170.195]:44661 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S268119AbUIVXZj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 19:25:39 -0400
Message-ID: <311601c904092216257bfd5752@mail.gmail.com>
Date: Wed, 22 Sep 2004 17:25:38 -0600
From: Eric Mudama <edmudama@gmail.com>
Reply-To: Eric Mudama <edmudama@gmail.com>
To: "valdis.kletnieks@vt.edu" <valdis.kletnieks@vt.edu>
Subject: Re: The ultimate TOE design
Cc: David Stevens <dlstevens@us.ibm.com>, Netdev <netdev@oss.sgi.com>,
       leonid.grossman@s2io.com, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200409172027.i8HKRVwY005444@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4148991B.9050200@pobox.com>
	 <OF8783A4F6.D566336C-ON88256F10.006E51CE-88256F10.006EDA93@us.ibm.com>
	 <311601c90409162346184649eb@mail.gmail.com>
	 <200409172027.i8HKRVwY005444@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Sep 2004 16:27:31 -0400, valdis.kletnieks@vt.edu
<valdis.kletnieks@vt.edu> wrote:
> No, he means "offload the processing of the filesystem to the disk itself".

I know what was meant.

I'm not saying the filesystem on the drive is very advanced, but it's
still a filesystem.  Our "Record ID" is the LBA identifier, and all
records are 1 block in size.  We can handle defects, reallocations,
and other issues, with some success.
