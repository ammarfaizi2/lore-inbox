Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264802AbRGCP7w>; Tue, 3 Jul 2001 11:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264804AbRGCP7m>; Tue, 3 Jul 2001 11:59:42 -0400
Received: from cop.Informatik.TU-Cottbus.DE ([141.43.3.1]:43704 "EHLO
	cop.Informatik.TU-Cottbus.DE") by vger.kernel.org with ESMTP
	id <S264802AbRGCP73>; Tue, 3 Jul 2001 11:59:29 -0400
Date: Tue, 3 Jul 2001 17:59:22 +0200
From: Guenter Millahn <Guenter.Millahn@Informatik.TU-Cottbus.DE>
To: "David S. Miller" <davem@redhat.com>
Cc: Aaron Lehmann <aaronl@vitelus.com>, linux-kernel@vger.kernel.org,
        jakub@redhat.com
Subject: Re: Linux speed on sun4c
Message-ID: <20010703175922.A7970@pt.Informatik.TU-Cottbus.DE>
Reply-To: Guenter.Millahn@Informatik.TU-Cottbus.DE (Guenter Millahn)
In-Reply-To: <20010630220612.C14361@vitelus.com> <15166.50418.583094.554723@pizda.ninka.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <15166.50418.583094.554723@pizda.ninka.net>
Organization: Brandenburg University of Technology, DB & IS Group, Cottbus
X-Phone: +49 (355) 69-2272 or -2700
X-Fax: +49 (355) 69-2766
X-Business-Email: Guenter.Millahn@Informatik.TU-Cottbus.DE
X-Private-Email: Guenter.Millahn@Web.DE
X-URL: http://WWW.Informatik.TU-Cottbus.DE/~gm/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Jun 2001, David S. Miller wrote:

> Aaron Lehmann writes:
>  > NetBSD/Sparc's FAQ asserts:
>  > 
>  >     Why is NetBSD so much faster than SparcLinux on sun4c (top) 
>  > 
>  >         The memory management hardware on sun4c machines (SPARCStation
>  >         1, 1+, 2, IPC, IPX, SLC, ELC and clones) is not handled particularly
>  >         well by Linux. Until Linux reworks their MMU code NetBSD will be very
>  >         much faster on this hardware. 
>  > 
>  > Was there ever any truth to this statement? It seems to be light on
>  > technical details. Have these purported issues ever been fixed?
>  > 
>  > I don't want to be scared into running NetBSD on my SparcStation 2 :D.


What about OpenBSD?  Same as NetBSD?



> It's totally true, use *BSD on your sun4c systems if top performance
> is your desire. :-)
> 
> I know how to fix it but frankly I have no desire to work on
> that platform any more.
> 
> Later,
> David S. Miller
> davem@redhat.com


David, can you publish your idea for a fix? Possibly anybody elese can make
the patch?

Thanks, Guenter

-- 
Dipl.-Ing. Guenter Millahn         Brandenburg University of Technology
Systems, Network & DB Admin        CS Dept / DB & IS Research Group
Voice: +49 (355) 69-2272/2700      P.O. Box: 10 13 44
Fax:   +49 (355) 69-2766           D-03013 Cottbus              GERMANY

"The real world is still far away from be led ad absurdum by the virtual
one."    (Hal Faber, newsreel "What happened, what will be", 08/13/2000)
