Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267248AbUH1FqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267248AbUH1FqF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 01:46:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268185AbUH1FqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 01:46:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:9916 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267248AbUH1FqD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 01:46:03 -0400
Date: Fri, 27 Aug 2004 22:42:38 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: nickpiggin@yahoo.com.au, hugh@veritas.com, dice@mfa.kfki.hu,
       vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
Subject: Re: data loss in 2.6.9-rc1-mm1
Message-Id: <20040827224238.2d2301c0.akpm@osdl.org>
In-Reply-To: <1093669312.11648.80.camel@dyn319181.beaverton.ibm.com>
References: <Pine.LNX.4.44.0408271950460.8349-100000@localhost.localdomain>
	<1093640668.11648.50.camel@dyn319181.beaverton.ibm.com>
	<41300B82.8080203@yahoo.com.au>
	<1093669312.11648.80.camel@dyn319181.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> this is the 4th time we are trying to nail down the same thing. We
>  better get it right this time. So any correct patch is ok with me.

There's no rush and it's a kernel fastpath.  Let's get the optimal code
debugged and merged, please.

