Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289243AbSBXCYL>; Sat, 23 Feb 2002 21:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289239AbSBXCYD>; Sat, 23 Feb 2002 21:24:03 -0500
Received: from 1Cust130.tnt6.lax7.da.uu.net ([67.193.244.130]:55291 "HELO
	cx518206-b.irvn1.occa.home.com") by vger.kernel.org with SMTP
	id <S289210AbSBXCXr>; Sat, 23 Feb 2002 21:23:47 -0500
Subject: Re: [PATCHSET] Linux 2.4.18-rc3-jam1
To: barryn@pobox.com (Barry K. Nathan)
Date: Sat, 23 Feb 2002 18:24:51 -0800 (PST)
Cc: jamagallon@able.es (J.A. Magallon), barryn@pobox.com (Barry K. Nathan),
        linux-kernel@vger.kernel.org (Lista Linux-Kernel),
        rwhron@earthlink.net
In-Reply-To: <20020223233949.02B7089C87@cx518206-b.irvn1.occa.home.com> from "Barry K. Nathan" at Feb 23, 2002 03:39:49 PM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20020224022451.E749B89C87@cx518206-b.irvn1.occa.home.com>
From: barryn@pobox.com (Barry K. Nathan)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Barry K. Nathan wrote:
> In fact, all I need is plain 2.4.17 + irqrate-A1. That's it. That's all I
> need to get floppy accesses to hang 100% of the time. 2.4.17 without
> irqrate does not have this problem.

For that matter, 2.4.14-pre7 (the earliest that I can apply the irqrate-A1
patch to without rejects) + irqrate-A1 also causes the floppy freeze for
me. By "freeze" I mean my mouse pointer stops moving for me in X and I'm
unable to switch virtual consoles.

-Barry K. Nathan <barryn@pobox.com>
