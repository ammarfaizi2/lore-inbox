Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbTGJINM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:13:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269083AbTGJILE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:11:04 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42434 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269056AbTGJIIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:08:06 -0400
Date: Thu, 10 Jul 2003 01:23:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: Piet Delaney <piet@www.piet.net>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.74-mm3 - module-init-tools: necessary to replace root
 copies?
Message-Id: <20030710012312.424b1ca2.akpm@osdl.org>
In-Reply-To: <1057824946.15253.30.camel@www.piet.net>
References: <20030708223548.791247f5.akpm@osdl.org>
	<200307091106.00781.schlicht@uni-mannheim.de>
	<20030709021849.31eb3aec.akpm@osdl.org>
	<1057815890.22772.19.camel@www.piet.net>
	<20030710060841.GQ15452@holomorphy.com>
	<20030710071035.GR15452@holomorphy.com>
	<20030710001853.5a3597b7.akpm@osdl.org>
	<1057824946.15253.30.camel@www.piet.net>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Piet Delaney <piet@www.piet.net> wrote:
>
>  Also, do you think it's better to enable the use
>  frame pointer when using kgdb.

Enabled, definitely.

> In the past I thought
>  I had problems with modules due to my enabling the
>  frame pointer being used.

No, there are no such problems.
