Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSH0SAy>; Tue, 27 Aug 2002 14:00:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316659AbSH0SAy>; Tue, 27 Aug 2002 14:00:54 -0400
Received: from ip213-185-39-113.laajakaista.mtv3.fi ([213.185.39.113]:20657
	"HELO dag.newtech.fi") by vger.kernel.org with SMTP
	id <S316609AbSH0SAx> convert rfc822-to-8bit; Tue, 27 Aug 2002 14:00:53 -0400
Message-ID: <20020827180510.24175.qmail@dag.newtech.fi>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-0.27
To: "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       dag@newtech.fi
Subject: Re: interrupt latency 
In-Reply-To: Message from "Wessler, Siegfried" <Siegfried.Wessler@de.hbm.com> 
   of "Tue, 27 Aug 2002 11:58:12 +0200." <D3524C0FFDC6A54F9D7B6BBEECD341D5D56FDB@HBMNTX0.da.hbm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Tue, 27 Aug 2002 21:05:10 +0300
From: Dag Nygren <dag@newtech.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello,
> 
> I am running and will in near future kernel 2.4.18 on an embedded system.
> 
> I have to speed up interrupt latency and need to understand how in what
> timing tasklets are called and arbitraded.

Have you already checked if the low-latency patch and/or the preempt patch
that is out there could do the trick for you ?

Good luck


-- 
Dag Nygren                               email: dag@newtech.fi
Oy Espoon NewTech Ab                     phone: +358 9 8024910
Träsktorpet 3                              fax: +358 9 8024916
02360 ESBO                              Mobile: +358 400 426312
FINLAND


