Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130293AbQKGWxZ>; Tue, 7 Nov 2000 17:53:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130312AbQKGWxH>; Tue, 7 Nov 2000 17:53:07 -0500
Received: from cerberus.s2k.com ([204.176.206.253]:40971 "EHLO
	cerberus.s2k.com") by vger.kernel.org with ESMTP id <S129868AbQKGWxB>;
	Tue, 7 Nov 2000 17:53:01 -0500
Subject: Re: Installing kernel 2.4
X-Mailer: Lotus Notes Release 5.0.3  March 21, 2000
Message-ID: <OFB23363D7.251AC99F-ON85256990.007D2BFC@infinium.com>
Date: Tue, 7 Nov 2000 17:49:10 -0500
X-MIMETrack: Serialize by Router on WHQNTSE1/Infinium Software(Release 5.0.4 |June 8, 2000) at
 11/07/2000 05:52:45 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
To: linux-kernel@vger.kernel.org
From: Bruce_Holzrichter@infinium.com
Cc: jmerkey@timpanogas.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I don't know about you, but I like having the option to cut out code from
my kernel that will never get used for a particular cpu arch.....;o)

Or was that just a troll ;o)
----- Forwarded by Bruce Holzrichter/US/Infinium Software on 11/07/2000
05:46 PM -----
                                                                                                 
                    "Jeff V. Merkey"                                                             
                    <jmerkey@timpanogas.org>        To:     Martin Josefsson                     
                    Sent by:                        <gandalf@wlug.westbo.se>                     
                    linux-kernel-owner@vger.        cc:     Tigran Aivazian                      
                    kernel.org                      <tigran@veritas.com>, Anil kumar             
                                                    <anils_r@yahoo.com>,                         
                                                    linux-kernel@vger.kernel.org                 
                    11/07/2000 05:32 PM             Subject:     Re: Installing kernel 2.4       
                                                                                                 
                                                                                                 





So how come NetWare and NT can detect this at run time, and we have to
use a .config option to specifiy it?  Come on guys.....

Jeff

Martin Josefsson wrote:
>
> On Tue, 7 Nov 2000, Tigran Aivazian wrote:
>
> > On Tue, 7 Nov 2000, Anil kumar wrote:
> > >   The system hangs after messages:
> > >   loading linux......
> > >   uncompressing linux, booting linux kernel OK.
> > >
> > >   The System hangs here.
> > >
> > >   Please let me know where I am wrong
> >
> > Hi Anil,
> >
> > The only serious mistake you did was using test9 kernel when
test11-pre1
> > (or at least test10) was available. So, redo everything you have done
with
> > test11-pre1 and if you still cannot boot then send a message to this
list
> > with details like your CPUs, motherboard etc. etc.
>
> Have you chosen the right cpu type in the configuration?
>
> /Martin
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
