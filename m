Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbUB0Smy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 13:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262939AbUB0Slu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 13:41:50 -0500
Received: from hera.kernel.org ([63.209.29.2]:55501 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262935AbUB0Sla (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 13:41:30 -0500
To: linux-kernel@vger.kernel.org
From: hpa@zytor.com (H. Peter Anvin)
Subject: Re: BOOT_CS
Date: Fri, 27 Feb 2004 18:41:26 +0000 (UTC)
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <c1o30m$iae$1@terminus.zytor.com>
References: <20040226121713.21924.qmail@web11804.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: terminus.zytor.com 1077907286 18767 63.209.29.3 (27 Feb 2004 18:41:26 GMT)
X-Complaints-To: news@terminus.zytor.com
NNTP-Posting-Date: Fri, 27 Feb 2004 18:41:26 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20040226121713.21924.qmail@web11804.mail.yahoo.com>
By author:    =?iso-8859-1?q?Etienne=20Lorrain?= <etienne_lorrain@yahoo.fr>
In newsgroup: linux.dev.kernel
> 
>   This interface is nice when the VCPI is loaded and running, but if
>  only EMM386 is loaded and VCPI not active you cannot use it.
> 

This has nothing to do with anything.  You're totally confused.

I'm referring to a hook in the kernel; it has nothing to do with VCPI,
EMM386 or LOADLIN, except that the latter uses the kernel interface
when using VCPI.

	-hpa

