Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932203AbVJCJ3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932203AbVJCJ3f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 05:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbVJCJ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 05:29:35 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:32493 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932203AbVJCJ3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 05:29:34 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: 2.6.13-rc6-xx-all.diff is not working for 2.6.13 arm kernel
Date: Mon, 3 Oct 2005 12:27:34 +0300
User-Agent: KMail/1.8.2
Cc: bcrl@kvack.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org
References: <20051003092208.96452.qmail@web8401.mail.in.yahoo.com>
In-Reply-To: <20051003092208.96452.qmail@web8401.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510031227.34961.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 October 2005 12:22, vikas gupta wrote:
> hi ben ,
> 
> I tried to apply 2.6.13-rc6-B0/B1-all.diff to
> linux-2.6.13 kernel with arm support patches . It's
> getting applied cleanly...
> but while building the kernel i am getting some build
> errors ... 
> i traced the problem and get that this error are
> coming because of some machine specific files.
> 1)arch/i386/kernel/semaphore.c
> 2)include/asm-i386/seamphore.h
> 
> So can you please tell me that whather any patch is
> available, in order to support these implementation on
> arm platform.

How nice that you did not show the actual error message
and did not show your .config

Please read REPORTING-BUGS in kernel tree.
--
vda
