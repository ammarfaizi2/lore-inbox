Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268955AbUIQPtp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268955AbUIQPtp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268957AbUIQPdl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:33:41 -0400
Received: from bi01p1.co.us.ibm.com ([32.97.110.142]:57737 "EHLO linux.local")
	by vger.kernel.org with ESMTP id S268860AbUIQPMS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:12:18 -0400
Date: Fri, 17 Sep 2004 08:07:59 -0700
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Dipankar Sarma <dipankar@in.ibm.com>
Cc: Kaigai Kohei <kaigai@ak.jp.nec.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] list_replace_rcu() in include/linux/list.h
Message-ID: <20040917150759.GA1306@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <200409171019.i8HAJgYV002200@mailsv.bs1.fc.nec.co.jp> <20040917104410.GB3785@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040917104410.GB3785@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2004 at 04:14:10PM +0530, Dipankar Sarma wrote:
> On Fri, Sep 17, 2004 at 07:19:42PM +0900, Kaigai Kohei wrote:
> > Hi Andrew.
> > 
> > +/*
> > + * list_replace_rcu - replace old entry by new onw from list
> 
> Apart from the spelling mistake in this line, it looks good. In fact,
> the whole selinux scalability work is really important and I hope will
> go to mainline soon.

What he said!  ;-)

The patch looks good to me, and the improved selinux scalability is
quite valuable.

							Thanx, Paul
