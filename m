Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbTISReG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 13:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbTISReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 13:34:06 -0400
Received: from [62.241.33.80] ([62.241.33.80]:32516 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261646AbTISReF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 13:34:05 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Roland Bless <bless@tm.uka.de>, miquels@cistron.nl,
       linux-kernel@vger.kernel.org
Subject: Re: Fix for wrong OOM killer trigger?
Date: Fri, 19 Sep 2003 19:30:33 +0200
User-Agent: KMail/1.5.3
Cc: walter@tm.uka.de, winter@tm.uka.de, doll@tm.uka.de
References: <20030919191613.36750de3.bless@tm.uka.de>
In-Reply-To: <20030919191613.36750de3.bless@tm.uka.de>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309191930.33969.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 19 September 2003 19:16, Roland Bless wrote:

Hi Roland,

> SW: Kernel 2.4.22 (also seen on 2.4.21, 2.4.22-ac3), lvm, software raid,
> reiserfs, SuSE 8.1. Swap turned off (see later).
> .... <snip> ....
> Anyone any ideas? Please Cc: to me in your replies since I'm not on the
> lkml. Cheers,

Please try v2.4.23-pre5 or rmap 15k for 2.4.22 vanilla.

ciao, Marc


