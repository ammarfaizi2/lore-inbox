Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283927AbRLEKDg>; Wed, 5 Dec 2001 05:03:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283926AbRLEKD0>; Wed, 5 Dec 2001 05:03:26 -0500
Received: from web13104.mail.yahoo.com ([216.136.174.149]:57353 "HELO
	web13104.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S283925AbRLEKDL>; Wed, 5 Dec 2001 05:03:11 -0500
Message-ID: <20011205100310.37607.qmail@web13104.mail.yahoo.com>
Date: Wed, 5 Dec 2001 11:03:10 +0100 (CET)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Your patch for CS432x sound driver
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16BBYJ-0001Jz-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
My box is: Cyrix 486, 12Meg RAM, CS4239 ISA sound
card,
no pci controler
I tested your patch both with kernel 2.4.14 +
 preemptible patches + ide patches , and with
kernel 2.4.16 clean.
The patch applied cleanly on both kernels.
The play command is working like it was working 
without this patch.
But when I was running mtv (http://www.mpegtv.com) 
the only thing I can hear is noise.
Whithout your patch mtv is playing the sound with
interrupts.
I didn't done extended testing because i don't have
 sound files on my computer (just movies) but if you
 want something specific tested please let me know 
and i'll try to help
Bye

=====
,-----.
                       ," ^   ^ ",
                       |  @   @  |
             ----OOOO---------------OOOO----

___________________________________________________________
Nokia 5510 Drôle de look... et quel son !
Cliquez sur http://fr.promotions.yahoo.com/nokia/ 
Découvrez-le et tentez votre chance pour en gagner un ! 
Fin du concours le 16 décembre.
