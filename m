Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271129AbRHTITO>; Mon, 20 Aug 2001 04:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271126AbRHTITE>; Mon, 20 Aug 2001 04:19:04 -0400
Received: from [62.46.87.251] ([62.46.87.251]:4503 "EHLO mannix")
	by vger.kernel.org with ESMTP id <S271129AbRHTISr>;
	Mon, 20 Aug 2001 04:18:47 -0400
To: Joachim Backes <backes@rhrk.uni-kl.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.4.9, esssolo soundcard, NTFS support
In-Reply-To: <XFMail.20010820093559.backes@rhrk.uni-kl.de>
In-Reply-To: <XFMail.20010820093559.backes@rhrk.uni-kl.de>
Reply-To: tuxx@aon.at
X-Signature-Color: black
X-Registered-Linux-User: 174382
X-Face: 5{SZ#3.-&)VX(Cd6yo<,A-?Lel6JM@c-c[X\P:m5FG>"vM9U/n`Git/~!)'YU;r"RZ")EKuX'gS9[:Oh)/rI*i1AS^g0xN'\/@UK?q|x^-KQ3!_N:;u7bul4|~iu^l-o_=_7$?v[i3`R?oanu}kpbR#X$M[HH)1\)X0p0X5N7OkG~&k&VhA<VZI=Loy/'BC?^{M=g@q'~uxsXtE)&6c={U*dq,N
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <E15YkGb-0002Q8-00@mannix>
From: Alexander Griesser <tuxx@aon.at>
Date: Mon, 20 Aug 2001 10:18:37 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Outlook Users may want to press <CTRL> + <F3> here.
begin  followup on Joachim Backes:
>  having problems to build a 2.4.9 kernel with soundcard support (esssolo
>  for ex.). After having built the kernel with sound modules, depmod           >  complains about unresolved gameport_register_port and gameport_unregister_   +++port.

http://students.htblmo-klu.ac.at/tuxx/kernel-patches/es137x-2.4.6-ac2.diff

This is a workaround for your problem, should apply in 2.4.9 hopefully.

>  What has gameport to do with the soundcard support?

There are gameports an soundcards :)

>  Compiling the kernel with NTFS support fails during compilations of the
>  NTFS modules:

Known issue, discussed quite often here.
Do you people search the archives, before posting?

regards, alexx
--
|   .-.   | Alexander Griesser <tuxx@aon.at> -=- ICQ:63180135 |  .''`. |
|   /v\   |  http://www.tuxx-home.at -=- Linux Version 2.4.9  | : :' : |
| /(   )\ |  FAQ zu at.linux:  http://alfie.ist.org/LinuxFAQ  | `. `'  |
|  ^^ ^^  `---------------------------------------------------´   `-   |
