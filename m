Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266633AbUIIWVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266633AbUIIWVt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 18:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267940AbUIIWVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 18:21:49 -0400
Received: from web52902.mail.yahoo.com ([206.190.39.179]:58499 "HELO
	web52902.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266633AbUIIWVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 18:21:45 -0400
Message-ID: <20040909222145.42540.qmail@web52902.mail.yahoo.com>
Date: Thu, 9 Sep 2004 23:21:45 +0100 (BST)
From: =?iso-8859-1?q?Chris=20Rankin?= <rankincj@yahoo.com>
Subject: RE: Latest microcode data from Intel.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have received and tested the latest microcode data
> file from Intel, The file is dated 2nd September
> 2004.

Aha! And this microcode file actually contains data
for my dual P4 Xeons (HT):

IA-32 Microcode Update Driver: v1.14 <tigran@xxxx>
microcode: CPU2 updated from revision 0x18 to 0x22,
date = 03242004
microcode: CPU1 updated from revision 0x18 to 0x22,
date = 03242004
microcode: CPU0 updated from revision 0x18 to 0x22,
date = 03242004
microcode: CPU3 updated from revision 0x18 to 0x22,
date = 03242004

The July 27th offering didn't contain anything for
these CPUs at all. In fact, the July file was
suspiciously smaller than the one from 16th March.

Chris



	
	
		
___________________________________________________________ALL-NEW Yahoo! Messenger - all new features - even more fun!  http://uk.messenger.yahoo.com
