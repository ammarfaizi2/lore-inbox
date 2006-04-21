Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932220AbWDUMwj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbWDUMwj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 08:52:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbWDUMwj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 08:52:39 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:62684 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932217AbWDUMwi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 08:52:38 -0400
Date: Fri, 21 Apr 2006 14:52:35 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Patrick McHardy <kaber@trash.net>
cc: mikado4vn@gmail.com, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which process is associated with process ID 0 (swapper)
In-Reply-To: <Pine.LNX.4.61.0604211447310.23180@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0604211452160.23180@yvahk01.tjqt.qr>
References: <4447A19E.9000008@gmail.com> <Pine.LNX.4.61.0604201118200.5749@chaos.analogic.com>
 <4447B110.4080700@gmail.com> <Pine.LNX.4.61.0604210007140.28841@yvahk01.tjqt.qr>
 <44481ACE.9040104@gmail.com> <44482963.4030902@trash.net>
 <Pine.LNX.4.61.0604211447310.23180@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Either way, I'd just be happy to match on "who created this socket" (don't 
>need "who sends" ATM) without trying to set up SELinux...

Which is... what seems remained in ipt_owner :D
