Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSLaJrr>; Tue, 31 Dec 2002 04:47:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261295AbSLaJrq>; Tue, 31 Dec 2002 04:47:46 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:51852 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S261286AbSLaJrq> convert rfc822-to-8bit; Tue, 31 Dec 2002 04:47:46 -0500
Message-Id: <4.3.2.7.2.20021231104452.00aeaf00@pop.t-online.de>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 31 Dec 2002 10:56:46 +0100
To: linux-kernel@vger.kernel.org
From: margitsw@t-online.de (Margit Schubert-While)
Subject: Re: [PATCHSET] 2.4.21-pre2-jp15
Cc: joergprante@netcologne.de
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jörg,
	My config is A1 OK !
--snip --
# CONFIG_PREEMPT is not set
# CONFIG_PREEMPT_TIMES is not set
# CONFIG_PREEMPT_LOG is not set
-- end snip --

	As I said, you NEED the ifdef in sysrq.c. Look again.

	Re: scx200 - OK, I had sorted that one myself.

	Re: comx
	Sorry - procfs is configured. Don't know what's going on here.
  --snip --
CONFIG_PROC_FS=y
-- end snip --

	Re: irda - OK

	Margit

