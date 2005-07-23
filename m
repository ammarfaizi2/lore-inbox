Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262362AbVGWFmm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVGWFmm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 01:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbVGWFmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 01:42:42 -0400
Received: from dial169-39.awalnet.net ([213.184.169.39]:22023 "EHLO
	raad.intranet") by vger.kernel.org with ESMTP id S262365AbVGWFk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 01:40:26 -0400
Message-Id: <200507230535.IAA03518@raad.intranet>
From: "Al Boldi" <a1426z@gawab.com>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: "'Blaisorblade'" <blaisorblade@yahoo.it>,
       "'LKML'" <linux-kernel@vger.kernel.org>,
       "'Andrian Bunk'" <bunk@stusta.de>, "'H. Peter Anvin'" <hpa@zytor.com>,
       <torvalds@osdl.org>, "'Alejandro Bonilla'" <abonilla@linuxwireless.org>
Subject: RE: Giving developers clue how many testers verifiedcertain	kernel version
Date: Sat, 23 Jul 2005 08:34:57 +0300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcWPNUJmoEivN52PQNaFOT1fxTqnAQAEawqQ
In-Reply-To: <1122088863.6510.19.camel@mindpipe>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote: {
On Fri, 2005-07-22 at 21:15 -0500, Alejandro Bonilla wrote:
> OK, I will, but I first of all need to learn how to tell if benchmarks 
> are better or worse.

Con's interactivity benchmark looks quite promising for finding scheduler
related interactivity regressions.
}

Scheduler performance does not imply net system performance.

In fact, a well tuned scheduler hides absolute performance-related issues!

--Al


