Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268677AbUIQKjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268677AbUIQKjb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 06:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268680AbUIQKjb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 06:39:31 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:2814 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268677AbUIQKj3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 06:39:29 -0400
Date: Fri, 17 Sep 2004 16:14:10 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulmck@us.ibm.com
Subject: Re: [PATCH] list_replace_rcu() in include/linux/list.h
Message-ID: <20040917104410.GB3785@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200409171019.i8HAJgYV002200@mailsv.bs1.fc.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409171019.i8HAJgYV002200@mailsv.bs1.fc.nec.co.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 07:19:42PM +0900, Kaigai Kohei wrote:
> Hi Andrew.
> 
> +/*
> + * list_replace_rcu - replace old entry by new onw from list

Apart from the spelling mistake in this line, it looks good. In fact,
the whole selinux scalability work is really important and I hope will
go to mainline soon.

Thanks
Dipankar
