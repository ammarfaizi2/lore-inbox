Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbTDMWzp (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 18:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262657AbTDMWzp (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 18:55:45 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:19725
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262656AbTDMWzo 
	(for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 18:55:44 -0400
Subject: Re: Preempt on PowerPC/SMP appears to leak memory
From: Robert Love <rml@tech9.net>
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: David Brown <dave@codewhore.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200304140103.26761.m.c.p@wolk-project.de>
References: <20030412152951.GA10367@codewhore.org>
	 <1050271044.767.7.camel@localhost>
	 <200304140103.26761.m.c.p@wolk-project.de>
Content-Type: text/plain
Organization: 
Message-Id: <1050275256.767.9.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 13 Apr 2003 19:07:36 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-04-13 at 19:03, Marc-Christian Petersen wrote:

> This is an incremental diff snipplet. The second preempt_disable(); should be 
> a preempt_enable(); no?

Yep.  Thanks.

	Robert Love

