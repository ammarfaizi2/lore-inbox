Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVDOX3v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVDOX3v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 19:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVDOX3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 19:29:51 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:9127 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S262262AbVDOX3m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 19:29:42 -0400
From: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>
Subject: Re: intercepting syscalls
To: linux-os@analogic.com, Daniel Souza <thehazard@gmail.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Igor Shmukler <igor.shmukler@gmail.com>, linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Sat, 16 Apr 2005 01:05:39 +0200
References: <3TDqB-32g-21@gated-at.bofh.it> <3TDAk-38r-23@gated-at.bofh.it> <3TEZl-4eW-23@gated-at.bofh.it> <3TF9b-4lu-25@gated-at.bofh.it> <3TFiG-4Cc-11@gated-at.bofh.it> <3TFsj-4HP-3@gated-at.bofh.it> <3TFsl-4HP-17@gated-at.bofh.it> <3TFC7-4Og-29@gated-at.bofh.it> <3TFVm-50J-5@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DMZsZ-0001Tv-GS@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson <linux-os@analogic.com> wrote:

> LD_PRELOAD some custom 'C' runtime library functions, grab open()
> read(), write(), etc.

This will work wonderfully with static binaries.
-- 
"Bravery is being the only one who knows you're afraid."
-David Hackworth

