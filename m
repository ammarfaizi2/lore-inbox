Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132690AbRC2ObK>; Thu, 29 Mar 2001 09:31:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132723AbRC2ObA>; Thu, 29 Mar 2001 09:31:00 -0500
Received: from ns2.servicenet.com.ar ([200.41.148.12]:23816 "EHLO
	servnet.servicenet.com.ar") by vger.kernel.org with ESMTP
	id <S132739AbRC2Oat>; Thu, 29 Mar 2001 09:30:49 -0500
Message-ID: <A0C675E9DC2CD411A5870040053AEBA0284145@MAINSERVER>
From: =?iso-8859-1?Q?Sarda=F1ons=2C_Eliel?= 
	<Eliel.Sardanons@philips.edu.ar>
To: "'George Wright'" <wrightg@edgegrove.herts.sch.uk>,
   "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Newbie to Kernel Development
Date: Thu, 29 Mar 2001 11:32:07 -0300
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.0.1461.28)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kernel/printk.c

as you can see printk use vsprintf :)

vsprintf was coded by linus torvalds! .. 

and printf use vsprintf :)

-------------

ELF / a.out are binary formats ..... let say when you compile a program a
header is appended to know let say when the code start, where the data start
in the file... and a lot of more info... a.out is an old especification and
ELF is newer... But you need to know more so, you can find more info in the
linux kernel... 

If i'm wrong please tell me... 

Eliel Sardanons

> -----Mensaje original-----
> De:	George Wright [SMTP:wrightg@edgegrove.herts.sch.uk]
> Enviado el:	Thursday, March 29, 2001 11:08 AM
> Para:	Linux Kernel Mailing List
> Asunto:	Newbie to Kernel Development
> 
> Hi all,
> 
> I am a newbie to Linux Kernel Development, with a very basic knowledge of
> C, 
> and an OK knowledge of C++/Qt.
> 
> I was wondering if the people on this list could help me with my learning
> of 
> C, and help me and bring me up to Kernel Developer status.
> 
> Looking through the source code, there are a lot of "printk"s. I believe
> that 
> this is an alternative to printf because printf was unsuitable for this 
> purpose, and that it was written by Linus Torvalds, but I don't see why 
> printf's not adequate.
> 
> I also would like to know about the Linux security model, as well as what 
> ELF/a.out is.
> 
> Many thanks,
> 
> George
> 
> --
> 
> Only wimps use tape backup: _real_    | George Wright - Edge Grove School
> - Age 13
> men just upload their important stuff |
> on ftp and let the rest of the world  | Work:
> wrightg@edgegrove.herts.sch.uk
> mirror it - Linus Torvalds            | Home:    georsoc@attglobal.net
>                                       | Play:    georsoc@navaho.net
>  _    _                               | Obsolete: geowr445@email.com
> ('>  <')   the lesser-spotted         |           geowr445@mail.com
> /_\  /_\     penguin (TUX!)           |
> w w  w w                              | Website:
> http://homepage.ntlworld.com/
>                                       |
> eric.rsoc/George
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
