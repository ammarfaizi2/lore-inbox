Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318158AbSHZR17>; Mon, 26 Aug 2002 13:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318159AbSHZR17>; Mon, 26 Aug 2002 13:27:59 -0400
Received: from pD9E2394F.dip.t-dialin.net ([217.226.57.79]:7602 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S318158AbSHZR17>; Mon, 26 Aug 2002 13:27:59 -0400
Date: Mon, 26 Aug 2002 11:31:44 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       Zheng Jian-Ming <zjm@cis.nctu.edu.tw>, <linux-kernel@vger.kernel.org>
Subject: Re: problems with changing UID/GID
In-Reply-To: <1030382219.1751.14.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208261131240.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 26 Aug 2002, Alan Cox wrote:
> > I personally like the task->cred->cr_uid, etc. approach. Helps a lot.
> 
> It changes the whole semantics of every security test in Linux, and
> breaks most of them totally. Our syscalls know the uid is constant
> during the call

I didn't say it's a must -- for now.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

