Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTJRRYZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTJRRYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:24:24 -0400
Received: from fw.osdl.org ([65.172.181.6]:17112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261724AbTJRRX5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:23:57 -0400
Date: Sat, 18 Oct 2003 10:24:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: bunk@fs.tum.de, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add a config option for -Os compilation
Message-Id: <20031018102402.3576af6c.akpm@osdl.org>
In-Reply-To: <649730000.1066491920@[10.10.2.4]>
References: <20031015225055.GS17986@fs.tum.de>
	<20031015161251.7de440ab.akpm@osdl.org>
	<20031015232440.GU17986@fs.tum.de>
	<20031015165205.0cc40606.akpm@osdl.org>
	<20031018102127.GE12423@fs.tum.de>
	<649730000.1066491920@[10.10.2.4]>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Please don't - I benchmarked it a while ago, and it's definitely slower.

Alan said he generally found -Os to be faster...
