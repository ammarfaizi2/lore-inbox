Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271722AbRIGLPN>; Fri, 7 Sep 2001 07:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271721AbRIGLPC>; Fri, 7 Sep 2001 07:15:02 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:35343 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S271719AbRIGLOu>; Fri, 7 Sep 2001 07:14:50 -0400
Date: Fri, 7 Sep 2001 13:15:10 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: hps@intermeta.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl SIOCGIFNETMASK: ip alias bug 2.4.9 and 2.2.19
Message-ID: <20010907131510.E13826@emma1.emma.line.org>
Mail-Followup-To: hps@intermeta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20010906203646.A11741@gruyere.muc.suse.de> <20010906185124.42C37BC06C@spike.porcupine.org> <9na43a$dk$1@forge.intermeta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <9na43a$dk$1@forge.intermeta.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henning P. Schmiedehausen schrieb am Freitag, den 07. September 2001:

> wietse@porcupine.org (Wietse Venema) writes:
> 
> % cd /home/distribution/RedHat-5.2/i386/
> % ls -la kernel*
> -r--r--r--    1 root     root      2216232 Oct 14  1998 kernel-2.0.36-0.7.i386.rpm

> You don't _WANT_ to listen, do you? Andi told you many times, that
> this is an Linux 2.1+ API. RH 5.2 is a 2.0 distribution. Of course,

So Postfix would still need the code for the -2.0 (BSD) API...
