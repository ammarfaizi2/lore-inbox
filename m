Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265189AbSJRPyC>; Fri, 18 Oct 2002 11:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265192AbSJRPyC>; Fri, 18 Oct 2002 11:54:02 -0400
Received: from mx.alles.or.jp ([210.231.151.65]:50858 "EHLO mx.alles.or.jp")
	by vger.kernel.org with ESMTP id <S265189AbSJRPyA>;
	Fri, 18 Oct 2002 11:54:00 -0400
Message-ID: <3DB03026.63AF250F@alles.or.jp>
Date: Sat, 19 Oct 2002 01:00:38 +0900
From: Takeharu Kato <tk1219@alles.or.jp>
X-Mailer: Mozilla 4.05 [ja] (Win95; I)
MIME-Version: 1.0
To: karim@opersys.com
CC: linux-kernel <linux-kernel@vger.kernel.org>, LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [ltt-dev] [ANNOUNCE] LTT 0.9.6pre2: Per-CPU buffers, TSC timestamps, etc.
References: <3DAF850D.D104A6D@opersys.com>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yaghmour:

Karim Yaghmour wrote:
> 
> A new development version of LTT is now available, 0.9.6pre2.
> Here's what's new:
> - Per-CPU buffering
> - TSC timestamping
> - Use of syscall interface instead of char dev abstraction
> 
As long as I think, 0.9.6pre2 has called CHAR DEV in LibUserTrace.
Should I apply the patch which you send before?

-- 
---------------------------
Takeharu KATO
E-mail: tk1219@alles.or.jp
