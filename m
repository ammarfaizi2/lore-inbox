Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUC2JLn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 04:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUC2JLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 04:11:43 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:5568 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S262772AbUC2JLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 04:11:42 -0500
Subject: Re: Kernel / Userspace Data Transfer
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <20040329124542.019edd8b.p.mironchik@sam-solutions.net>
References: <1080528430.40678e2e9eb3a@www.beonline.com.au>
	 <406799F3.1020508@opersys.com>
	 <20040329124542.019edd8b.p.mironchik@sam-solutions.net>
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1080551378.5830.0.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 29 Mar 2004 11:09:40 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-03-29 at 11:45, Pavel Mironchik wrote:
> The best Userspace-kernelspace-Userspace transfer thing is soket.
> Unix or TCP/UDP sockets API is avaible from kernel space.
> You should use it...

Do you mean Netlink ?

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

