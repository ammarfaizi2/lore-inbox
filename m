Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264274AbTLEQ7N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 11:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264282AbTLEQ7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 11:59:13 -0500
Received: from tag.witbe.net ([81.88.96.48]:61197 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id S264278AbTLEQ7K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 11:59:10 -0500
Message-Id: <200312051659.hB5Gx8D11738@tag.witbe.net>
From: "Paul Rolland" <rol@as2917.net>
To: "'Zwane Mwaikambo'" <zwane@arm.linux.org.uk>,
       "'Paul Rolland'" <rol@witbe.net>
Cc: <linux-smp@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: WARNING: MP table in the EBDA can be UNSAFE
Date: Fri, 5 Dec 2003 17:59:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcO7S/0d3wbro2XIRqiPT65XZrym5wABBCKQ
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-reply-to: <Pine.LNX.4.58.0312051113260.10913@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Indeed it is, you need to turn on "Multi-node NUMA system support"
> 
> CONFIG_X86_NUMA
> 
Gee... I was in a 2.4.20 kernel, and the SUMMIT option is not present,
but it is in 2.4.23...

I'll have to go to the server and do the re-installation using this
solution. I'll tell you Monday if it's working this way.

Regards, and many thanks for the tip,
Paul

