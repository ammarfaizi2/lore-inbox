Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277519AbRJERcU>; Fri, 5 Oct 2001 13:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277520AbRJERcK>; Fri, 5 Oct 2001 13:32:10 -0400
Received: from mail.spylog.com ([194.67.35.220]:39898 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S277519AbRJERcI>;
	Fri, 5 Oct 2001 13:32:08 -0400
Date: Fri, 5 Oct 2001 21:32:31 +0400
From: Andrey Nekrasov <andy@spylog.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.11-pre2-xfs
Message-ID: <20011005213231.C13046@spylog.ru>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <andy@spylog.ru> <20011005022213.A8501@spylog.ru> <200110051420.f95EKVr12837@jen.americas.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200110051420.f95EKVr12837@jen.americas.sgi.com>
User-Agent: Mutt/1.3.22i
Organization: SpyLOG ltd.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Steve Lord,

> Oh well, thats really useful, maybe __alloc_pages should report on its
> caller's caller.

I am use gcc gcc version 2.95.2 19991024 (release).
May be with egcs will be better result?


> > ...
> > swap_dup: Bad swap file entry 3f41e02c
> > VM: killing process forwarderng
> > swap_free: Bad swap offset entry 3ce50000
> > swap_free: Bad swap file entry 3f41e02c
> > swap_free: Bad swap offset entry 38bb5000
> > ...
> > 
> > What is it? Kernel or may be my hardware problem?


> Probably kernel, but I am not really an expert on this part of the system,
> is your swap a device or a file on a filesystem?

/dev/hdg1             1      4145   2089048+  82  Linux swap


-- 
bye.
Andrey Nekrasov, SpyLOG.
