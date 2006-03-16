Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWCPI1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWCPI1m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 03:27:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752252AbWCPI1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 03:27:42 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1431 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750763AbWCPI1l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 03:27:41 -0500
Subject: Re: Invalidating a page of a user level process.
From: Arjan van de Ven <arjan@infradead.org>
To: VISHAL NAHAR <naharvishalj@yahoo.co.in>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060316065930.85327.qmail@web8702.mail.in.yahoo.com>
References: <20060316065930.85327.qmail@web8702.mail.in.yahoo.com>
Content-Type: text/plain
Date: Thu, 16 Mar 2006 09:27:39 +0100
Message-Id: <1142497659.3041.18.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-03-16 at 06:59 +0000, VISHAL NAHAR wrote:
> Hello all,
>    I am stuck up at invalidation of a   page of a user
> level process.
> Wht i am doin is that i am calling a device driver
> ioctl func from a normal C prog in user space and
> passing a virtual address into the ioctl func .In the
> ioctl func (kernel space) i want to invalidate the
> corresponding page.I have used funcs like pte_clear,
> flush_tlb_page,page_remove_rmap,etc. but couldnt
> succeed.Also suggest if any locks have to be acquired
> .
> 
> Can anyone of u help me in page invalidation.I would
> be grateful.
> Thanking you  in advance

you forgot to attach your sourcecode.


