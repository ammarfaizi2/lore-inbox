Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290085AbSAWVDI>; Wed, 23 Jan 2002 16:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290083AbSAWVCs>; Wed, 23 Jan 2002 16:02:48 -0500
Received: from cpath.psinet.cl ([200.14.80.251]:30351 "EHLO cpath.psinet.cl")
	by vger.kernel.org with ESMTP id <S290081AbSAWVCq>;
	Wed, 23 Jan 2002 16:02:46 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Mauricio =?iso-8859-1?q?Nu=F1ez?= <mnunez@maxmedia.cl>
To: linux-kernel@vger.kernel.org
Subject: Re: Low latency for recent kernels
Date: Wed, 23 Jan 2002 18:04:15 -0300
X-Mailer: KMail [version 1.2]
In-Reply-To: <20020123091643.A182@earthlink.net> <3C4F0DFA.50601@lexus.com> <3C4F10F9.87A3B2E@zip.com.au>
In-Reply-To: <3C4F10F9.87A3B2E@zip.com.au>
MIME-Version: 1.0
Message-Id: <02012318041500.01883@mauricio.chile.com>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sending some feedback !
:-)

I'm trying this patch... (in 2.4.18-pre6)
I'm feeling a improved performance ,as a desktop user.
I'm working with KDE2, Netbeans and VMWare.
Pentium III 666Mhz , 192M Ram, 10GB HD.

What are the tools to check this better performance?
Or my impression is sufficient ?

Thanks

Mauricio

El Miércoles 23 Enero 2002 16:37, Andrew Morton escribió:
> J Sloan wrote:
> > Ditto here -
>
> Yes, sorry about that.  That patch had a completely untested,
> experimental and buggy chunk in it which kinda escaped from the
> factory.
>
> I've uploaded a saner version.
>
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
