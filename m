Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750703AbVJAAcE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750703AbVJAAcE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 20:32:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbVJAAcE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 20:32:04 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:3809 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750703AbVJAAcD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 20:32:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NP246Id2O7NNFlyVyuXpR37kD3Q7NI1mgTzFyF+eflUe/IC1IBTK3BBh5UMDOUUNyVC9Mfkq8GK1Cuma8dqwJbg6e0DQZM6fVFsCsN1ILn2Y76i5jPHZiHAd8OHJgu7FP/+mupVZRKhPefMNjUywCEDI2OvEmLD4edIfLzHMb60=
Message-ID: <aec7e5c30509301732n1b611d45qb137a14b7b621df8@mail.gmail.com>
Date: Sat, 1 Oct 2005 09:32:02 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 05/07] i386: sparsemem on pc
Cc: Magnus Damm <magnus@valinux.co.jp>, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1128093929.6145.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <20050930073258.10631.74982.sendpatchset@cherry.local>
	 <1128093929.6145.27.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
> > This patch for enables and fixes sparsemem support on i386. This is the
> > same patch that was sent to linux-kernel on September 6:th 2005, but this
> > patch includes up-porting to fit on top of the patches written by Dave Hansen.
>
> I'll post a more comprehensive way to do this in just a moment.
>
>         Subject: memhotplug testing: hack for flat systems

Looks much better, will compile and test on Monday. Thanks.

/ magnus
