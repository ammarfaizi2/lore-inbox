Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318351AbSGRU64>; Thu, 18 Jul 2002 16:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318352AbSGRU6v>; Thu, 18 Jul 2002 16:58:51 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:15136 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S318351AbSGRU6r>; Thu, 18 Jul 2002 16:58:47 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A783A7CAE@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'Matt_Domsch@Dell.com'" <Matt_Domsch@Dell.com>, RSinko@island.com,
       DHubbard@midamerican.com, linux-kernel@vger.kernel.org
Subject: RE: Wrong CPU count
Date: Thu, 18 Jul 2002 16:01:34 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> > That's interesting.  Can it be disabled?
> 
> It's an option in the BIOS Setup page (press F2 shortly after 
> power-on) on
> Dell servers which support disabling it.

That does raise a question from me, though.  With the ability disabled at
the bios level, will the kernel still be able to recognize the cpu's as
hyperthreaded, and bypass the bios disabling them? 

Thanks,
Bruce H.
