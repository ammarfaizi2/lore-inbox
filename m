Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131572AbRCSS6K>; Mon, 19 Mar 2001 13:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131587AbRCSS6A>; Mon, 19 Mar 2001 13:58:00 -0500
Received: from geos.coastside.net ([207.213.212.4]:47764 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S131586AbRCSS5s>; Mon, 19 Mar 2001 13:57:48 -0500
Mime-Version: 1.0
Message-Id: <p05100203b6dc04ae79d9@[207.213.214.34]>
In-Reply-To: <3AB64E33.A062439B@efftinc.com>
In-Reply-To: <001c01c0b04b$7b39df80$4c0c5c8c@trd.iii.org.tw>
 <3AB64E33.A062439B@efftinc.com>
Date: Mon, 19 Mar 2001 10:56:42 -0800
To: LinuxKernelMailList <linux-kernel@vger.kernel.org>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Please help
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I have a fundamental question:
>
>If I have to port LINUX on to new processor. How will I get address
>mapping of different devices. Some of them are available in the manual.
>Ex: NVram starting address is not available.
>Iam porting on mips3k.

Related question: does there exist any kind of definition of the abstract interface between the architecture-independent and architecture-dependent parts of the kernel? Or am I being naive?

-- 
/Jonathan Lundell.
