Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264902AbUFVXFD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264902AbUFVXFD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:05:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265087AbUFVXCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:02:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:61910 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265090AbUFVR61 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 13:58:27 -0400
Date: Tue, 22 Jun 2004 10:57:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: dipankar@in.ibm.com
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reduce rcu_head size [2/2]
Message-Id: <20040622105720.5576fdd0.akpm@osdl.org>
In-Reply-To: <20040622175058.GB3968@in.ibm.com>
References: <20040616054604.GA3658@in.ibm.com>
	<20040616054713.GB3658@in.ibm.com>
	<20040616054746.GC3658@in.ibm.com>
	<20040619120414.57d985f1.akpm@osdl.org>
	<20040620061224.GA14123@in.ibm.com>
	<20040622175058.GB3968@in.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma <dipankar@in.ibm.com> wrote:
>
>  Applies on top of the earlier patches.

OK, thanks.

I'm kinda twiddling thumbs on rcu-lock-update-*.patch.  As far as I'm
concerned these are ready to go.  Have you had a chance to review&test them?

