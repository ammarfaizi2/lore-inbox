Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317985AbSGLGcW>; Fri, 12 Jul 2002 02:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317987AbSGLGcV>; Fri, 12 Jul 2002 02:32:21 -0400
Received: from sproxy.gmx.net ([213.165.64.20]:4642 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S317985AbSGLGcV>;
	Fri, 12 Jul 2002 02:32:21 -0400
Message-ID: <000901c2296e$7cab2ed0$1c6fa8c0@hyper>
From: "Christian Ludwig" <cl81@gmx.net>
To: "Daniel Phillips" <phillips@arcor.de>,
       "Ville Herva" <vherva@niksula.hut.fi>
Cc: "Linux Kernel Mailinglist" <linux-kernel@vger.kernel.org>
References: <003d01c22819$ba1818b0$1c6fa8c0@hyper> <20020711062832.GU1548@niksula.cs.hut.fi> <002601c228ab$86b235e0$1c6fa8c0@hyper> <E17SheA-0002Uh-00@starship>
Subject: Re: bzip2 support against 2.4.18
Date: Fri, 12 Jul 2002 08:36:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.07.2001 - 19:21 Daniel Phillips wrote:
> How about bz2Image, or, more natural in my mind, bz2linux.

bzImage stands for "big zipped Image". Zipped, in this case, means that it
is gzipped. Perhaps Linus never wants to support other compression formats
for the kernel.
Sure "bz2bzImage" is a bit ugly. I personally would prefer bzImage.bz2,
although it is some kind of self-extracting executable, thus *.bz2 is also
not correct. But it would imply better which sort of compression you are
using. But that also means that the standard kernel has to be called
"bzImage.gz". I did not want to mess up the standard names...

But the question is: who is responsible for all those naming conventions?
Does anyone has an idea?

Have fun,

    - Christian


