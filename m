Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284696AbRLRT7O>; Tue, 18 Dec 2001 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284849AbRLRT7A>; Tue, 18 Dec 2001 14:59:00 -0500
Received: from pc3-stoc4-0-cust138.mid.cable.ntl.com ([213.107.175.138]:46596
	"EHLO buzz.ichilton.co.uk") by vger.kernel.org with ESMTP
	id <S284854AbRLRT5y>; Tue, 18 Dec 2001 14:57:54 -0500
From: "Ian Chilton" <ian@ichilton.co.uk>
To: "'Tony 'Nicoya' Mantler'" <nicoya@apia.dhs.org>,
        "'David S. Miller'" <davem@redhat.com>
Cc: <sparclinux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.17-rc1 wont do nfs root on Javastation
Date: Tue, 18 Dec 2001 19:57:45 -0000
Message-ID: <000001c187fe$42c675b0$0a01a8c0@dipsy>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
Importance: Normal
In-Reply-To: <v04003a11b84549aa834a@[24.70.162.28]>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Done a bit of checking and when the kernel boots, it says it got an
answer from my boot server and my ip is 67.0.0.0.

When I did arp -a on the boot server it said <incomplete> for the mac
address. I did a arp -f and it was fine, booted the javastation which
still got 67.0.0.0 and arp -a showed <incomplete> again.

Very strange!


Bye for Now,

Ian


                                  \|||/
                                  (o o)
 /-----------------------------ooO-(_)-Ooo----------------------------\
 |  Ian Chilton                    E-Mail: ian@ichilton.co.uk         |
 |  IRC Nick: GadgetMan            Backup: ian@linuxfromscratch.org   |
 |  ICQ: 16007717 & 106532995      Web   : http://www.ichilton.co.uk  |
 |--------------------------------------------------------------------|
 |          Your mouse has moved. Windows must be restarted           |
 |         for the change to take effect.  Reboot now? [ OK ]         |
 \--------------------------------------------------------------------/
 


