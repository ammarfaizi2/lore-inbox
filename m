Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265908AbTF3Uz4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jun 2003 16:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbTF3Uzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jun 2003 16:55:55 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:27667 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S265908AbTF3Uzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jun 2003 16:55:51 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Con Kolivas <kernel@kolivas.org>, Mike Galbraith <efault@gmx.de>
Subject: Re: patch-O1int-0306281420 for 2.5.73 interactivity
Date: Mon, 30 Jun 2003 23:09:28 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@digeo.com>
References: <200306301535.49732.kernel@kolivas.org> <5.2.0.9.2.20030630133424.00cfe800@pop.gmx.net> <200306302337.51171.kernel@kolivas.org>
In-Reply-To: <200306302337.51171.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306302309.28308.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 30 June 2003 15:38, Con Kolivas wrote:

Moin Con,

> Ok this munchkin has some more to contribute.
hehe.

> Here is the next patch which shows a large improvement. Gone is the
> unnecessary exponential function (sorry Pat it was fun), and now the patch
> will start calculating interactivity from the first time an application is
> activated.
nice.

> This takes away the X jerkiness evident in the previous patches (yes I do
> believe you MCP). No granularity patch is needed either.
ok.

> Please test the bejeesus out of this one; MCP your test case is the most
> valuable.
tyvm :) I'll give it a try in ~30 mins.

ciao, Marc

