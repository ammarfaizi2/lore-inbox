Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264901AbSLQLAM>; Tue, 17 Dec 2002 06:00:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264892AbSLQLAM>; Tue, 17 Dec 2002 06:00:12 -0500
Received: from [80.247.74.2] ([80.247.74.2]:915 "EHLO foradada.isolaweb.it")
	by vger.kernel.org with ESMTP id <S264889AbSLQLAL>;
	Tue, 17 Dec 2002 06:00:11 -0500
Message-Id: <5.2.0.9.0.20021217105617.00aa31e0@mail.isolaweb.it>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 17 Dec 2002 12:05:55 +0100
To: mgross@unix-os.sc.intel.com
From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: Multithreaded coredump patch where?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200212170015.gBH0FXP13878@unix-os.sc.intel.com>
References: <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it>
 <5.2.0.9.0.20021216182325.042a2b60@mail.isolaweb.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-scanner: scanned by Antivirus Service IsolaWeb Agency - (http://www.isolaweb.it)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 13.21 16/12/02 -0800, mgross wrote:

>I haven't rebased the patches I posted back in June for a while now.
>
>Attached is the patch I posted for the 2.4.18 vanilla kernel.  Its a bit
>controversial, but it seems to work for a number of folks.  Let me know if
>you have any troubles re-basing it.

Only one hunk failed on include/asm-ia64/elf.h but fixed by hand.
Why do you say a bit controversial ? One difference that I have
notice is in coredump size after your patch. However seem to be
working well for now. I'll try later on a SMP machine.


>I don't know if there is any plan to back port Ingo's version of this feature
>to 2.4.x
>
>--mgross
>
>
>
>On Monday 16 December 2002 09:28 am, Roberto Fichera wrote:
> > Does anyone point me where can I download a stable
> > multithread coredump patch for the 2.4.19/20 kernel ?
> >
> > Thanks in advance,
> >
> > Roberto Fichera.
> >
> >
> > ______________________________________
> > E-mail protetta dal servizio antivirus di IsolaWeb Agency & ISP
> > http://wwww.isolaweb.it
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/

Roberto Fichera. 


______________________________________
E-mail protetta dal servizio antivirus di IsolaWeb Agency & ISP
http://wwww.isolaweb.it
