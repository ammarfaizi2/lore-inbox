Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132620AbRADEVD>; Wed, 3 Jan 2001 23:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132726AbRADEUn>; Wed, 3 Jan 2001 23:20:43 -0500
Received: from s216-232-126-220.bc.hsia.telus.net ([216.232.126.220]:51708
	"EHLO gatekeeper.merilus.com") by vger.kernel.org with ESMTP
	id <S132620AbRADEUi>; Wed, 3 Jan 2001 23:20:38 -0500
Message-ID: <00ce01c075aa$fae55ec0$c901a8c0@merilus.com>
From: "Kevin Traas" <kevin@merilus.com>
To: <linux-kernel@vger.kernel.org>
Subject: Dell PERC RAID Controller
Date: Wed, 3 Jan 2001 09:30:56 -0800
Organization: Merilus Technologies
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oh, and I forgot to mention....

I'm not subscribed to this mailing list, so please be sure to
reply privately with any comments, questions, etc.

Regards,
Kevin


----- Original Message -----
From: "Kevin Traas" <kevin@merilus.com>
To: <linux-kernel@vger.rutgers.edu>; <debian-user@lists.debian.org>
Sent: Wednesday, January 03, 2001 9:22 AM
Subject: Dell PERC RAID Controller


> Greetings everyone,
>
> After much frustration in trying to get Debian GNU/Linux (my distro of
> choice) installed on a Dell PowerEdge 2450, I've finally found success!
>
> My problem was finding kernel support for the onboard PERC 3/Si RAID
> Controller (Adaptec OEM chipset) so that I could store my root fs with a
> RAID array container.  Turns out that Adaptec has recently open-sourced
the
> driver; however, it hasn't been accepted into any of the Linux kernel
trees
> as of yet.  So, I tracked down the driver sources (many thanks to Matt),
> patched them (5 patches in total) into 2.2.18, and built my own, new patch
> file to incorporate the aacraid 1.0.6 driver into this kernel in one, easy
> step.
>
> For anyone who's interested, you'll find the patch, a patched 2.2.18
kernel
> source archive, Debian (potato) installation disk images (with this new
> kernel), and other info at:
>
> http://www.merilus.com/~kevin/aacraid.html
>
>
> Regards,
> Kevin Traas
> Chief Information Officer
> Merilus Technologies, Inc.          .:|| Thinking inside the box ||:.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
