Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261471AbTHYFoL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 01:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbTHYFoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 01:44:11 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:10682 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261471AbTHYFoI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 01:44:08 -0400
Reply-To: <vlad@lrsehosting.com>
From: <vlad@lrsehosting.com>
To: "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Cc: "'Linus Torvalds'" <torvalds@osdl.org>
Subject: RE: Linux 2.6.0-test4
Date: Mon, 25 Aug 2003 00:43:16 -0500
Message-ID: <000001c36acb$c923fc70$0200a8c0@wsl3>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
Importance: Normal
In-Reply-To: <20030823153130.GA10855@gtf.org>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As a follow up to this, I downloaded and installed modutils and module init
tools, the latest versions available on kernel.org, did:

./configure
make all install

And I still get the same error as I was getting before. Is there somewhere
else I'm supposed to be looking, or did I miss a step building modutils and
module init tools?

Scott

--

-----Original Message-----
From: Jeff Garzik [mailto:jgarzik@pobox.com]
Sent: Saturday, August 23, 2003 10:32 AM
To: vlad@lrsehosting.com
Cc: 'Linus Torvalds'; 'Kernel Mailing List'
Subject: Re: Linux 2.6.0-test4


On Sat, Aug 23, 2003 at 07:26:45AM -0500, vlad@lrsehosting.com wrote:
> Getting this compile problem during modules_install, will paste in .config
> after the depmod errors:

Looks like you need new modutils...

	Jeff

