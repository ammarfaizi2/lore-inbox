Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130871AbRCFCRA>; Mon, 5 Mar 2001 21:17:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130869AbRCFCQu>; Mon, 5 Mar 2001 21:16:50 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:13831 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130871AbRCFCQk>; Mon, 5 Mar 2001 21:16:40 -0500
Subject: Re: Linux 2.4.2ac12
To: ksi@cyberbills.com (Sergey Kubushin)
Date: Tue, 6 Mar 2001 02:19:41 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31ksi3.0103051808160.28775-100000@nomad.cyberbills.com> from "Sergey Kubushin" at Mar 05, 2001 06:10:25 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14a74i-0008I8-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> May be. But it's not a reason to use the _OBSOLETE_ library. At least the
> current one should be used...
> 
> Here comes the patch to use current libdb-3...

Not all vendors ship db3. I'm not sure its a stunning improvement, but its
the right first step. Will apply

