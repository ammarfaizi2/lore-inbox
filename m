Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273588AbRK0JyF>; Tue, 27 Nov 2001 04:54:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282071AbRK0Jx7>; Tue, 27 Nov 2001 04:53:59 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:38841 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S273588AbRK0JwC>;
	Tue, 27 Nov 2001 04:52:02 -0500
Message-ID: <XFMail.20011127105200.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.5.1 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <E168eeJ-0005nt-00@calista.inka.de>
Date: Tue, 27 Nov 2001 10:52:00 +0100 (CET)
X-Face: B^`ajbarE`qo`-u#R^.)e]6sO?X)FpoEm\>*T:H~b&S;U/h$2>my}Otw5$+BDxh}t0TGU?>
 O8Bg0/jQW@P"eyp}2UMkA!lMX2QmrZYW\F,OpP{/s{lA5aG'0LRc*>n"HM@#M~r8Ub9yV"0$^i~hKq
 P-d7Vz;y7FPh{XfvuQA]k&X+CDlg"*Y~{x`}U7Q:;l?U8C,K\-GR~>||pI/R+HBWyaCz1Tx]5
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: Bernd Eckenfels <ecki@lina.inka.de>
Subject: Re: 2.4.12 ... 2.4.16, /dev/tty
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 27-Nov-2001 Bernd Eckenfels wrote: 
>  In article <XFMail.20011127085220.backes@rhrk.uni-kl.de> you wrote:
> > still having problems (starting with kernel 2.4.12) with
> > the /dev/tty device:
>  
>  Do you have devfs? In that case the Devices are generated dynamically.
>  
>  If you run ls on /dev/tty you should see an Entry with major 5 and minor
>  number 0.

 ls -l /dev/tty
crw-rw-rw-    1 root     root       5,   0 Nov 27 08:21 /dev/tty

/dev/tty was never missing!

>  
>  Greetings
>  Bernd
>  -
>  To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org
>  More majordomo info at  http://vger.kernel.org/majordomo-info.html
>  Please read the FAQ at  http://www.tux.org/lkml/

Regards

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, High Performance Computing  | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

