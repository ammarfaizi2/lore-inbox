Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130605AbQKNMRl>; Tue, 14 Nov 2000 07:17:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130918AbQKNMRc>; Tue, 14 Nov 2000 07:17:32 -0500
Received: from mailhost.intech.unu.edu ([192.87.143.4]:45065 "EHLO
	intech002.intech.unu.edu") by vger.kernel.org with ESMTP
	id <S130605AbQKNMRV>; Tue, 14 Nov 2000 07:17:21 -0500
Message-ID: <1100D69203AAD2118E3C00508B8B9E8A170940@mailhost.intech.unu.edu>
From: "Heupink, Mourik Jan C." <Heupink@INTECH.UNU.EDU>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
Date: Tue, 14 Nov 2000 12:47:19 +0100
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Short mail, because I really shouldn't be talking to Alan Cox himself, as
you are a real guru, and I'm really not. ;-)

Anyway: about this message, posted a while ago:

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> To: geoff@farmline.com
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: 2.2.17 & VM: do_try_to_free_pages failed / eepro100
> 
> > > VM: do_try_to_free_pages failed for httpd...
> > > VM: do_try_to_free_pages failed for httpd...
> 
> These if they are odd ones and the box continues are fine, if 
> you get masses
> of them then probably not
> 
> > (our quiet periods) the syslog is nearly empty. In extremis 
> it has been
> > necessary to reboot the machine by kicking the power button.
> 
> Are you using software raid ?

I have the same problem, and i AM running software raid. Therefore I would
very much like to know why you asked that question. For now, i changed back
to kernel 2.2.15, hoping that this solves the problems. But if they are
related to the raid stuff, please give me some pointers where to continue to
read, or what to do now.

(last two weeks two freezes) (so: nt runs more stable than linux at the
moment ;-))
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
