Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbTLECGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 21:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263806AbTLECGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 21:06:42 -0500
Received: from mail.scitechsoft.com ([63.195.13.67]:5087 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S263805AbTLECGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 21:06:39 -0500
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: andersen@codepoet.org
Date: Thu, 04 Dec 2003 18:07:59 -0800
MIME-Version: 1.0
Subject: Re: Linux GPL and binary module exception clause?
CC: linux-kernel@vger.kernel.org
Message-ID: <3FCF77FF.5814.44720535@localhost>
In-reply-to: <20031205004653.GA7385@codepoet.org>
References: <20031204235055.62846.qmail@web21503.mail.yahoo.com>
X-mailer: Pegasus Mail for Windows (v4.02)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> wrote:

> On Thu Dec 04, 2003 at 03:50:55PM -0800, Paul Adams wrote:
> > Unless actual Linux code is incorporated in a binary
> > distribution
> > in some form, I don't see how you can claim
> > infringement of the
> > copyright on Linux code, at least in the U.S.
> 
> A kernel module is useless without a Linux kernel in which it can
> be loaded.  Once loaded, it becomes not merely an adjunct, but an
> integrat part of the Linux kernel.  Further, it clearly
> "incorporate[s] a portion of the copyrighted work" since it can
> only operate within the context of the kernel by utilizing Linux
> kernel function calls. 

But what about the case I stated earlier for a driver that is completely 
binary portable between different operating systems. Hence the low level 
portion of the driver is not Linux specific at all, and in fact not even 
designed specifically with Linux in mind. That muddies the waters even 
more, and even Linus has said he would believe such a driver to be OK.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~

