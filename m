Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTLEQK3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264264AbTLEQK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:10:29 -0500
Received: from tag.witbe.net ([81.88.96.48]:18700 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264256AbTLEQKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:10:22 -0500
Message-Id: <200312051610.hB5GALD04677@tag.witbe.net>
From: "Paul Rolland" <rol@witbe.net>
To: "'Zwane Mwaikambo'" <zwane@arm.linux.org.uk>
Cc: <linux-smp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: MP table in the EBDA can be UNSAFE
Date: Fri, 5 Dec 2003 17:10:21 +0100
Organization: Witbe.net
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcO7SQUnYHbhcyAkTiyRaV8jV7m/XgAARzfw
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-reply-to: <Pine.LNX.4.58.0312051053481.10913@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Zwane,

> > WARNING: MP table in the EBDA can be UNSAFE, contact 
> linux-smp@vger.kernel.org if you experience SMP problems!
> 
> This bit is ok and can be safely ignored.
OK, so let's forget about this one.
 
> Did you compile your kernel with the following option?
> IBM x440 Summit/EXA support
> 
> CONFIG_X86_SUMMIT
> 
I can't find this option ? Is this part of the 2.4.x branch ?

Paul

