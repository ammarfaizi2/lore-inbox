Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265135AbRGANGB>; Sun, 1 Jul 2001 09:06:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265115AbRGANFl>; Sun, 1 Jul 2001 09:05:41 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:19208 "EHLO
	mailout02.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S265128AbRGANFh>; Sun, 1 Jul 2001 09:05:37 -0400
Date: 01 Jul 2001 11:15:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <840Ollemw-B@khms.westfalen.de>
In-Reply-To: <Pine.LNX.4.33.0106290730540.19843-100000@localhost.localdomain>
Subject: Re: Cosmetic JFFS patch.
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <83lrQramw-B@khms.westfalen.de> <Pine.LNX.4.33.0106290730540.19843-100000@localhost.localdomain>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

chuckw@altaserv.net (Chuck Wolber)  wrote on 29.06.01 in <Pine.LNX.4.33.0106290730540.19843-100000@localhost.localdomain>:

> > Does sed tell you who programmed it on startup?
> >
> > Awk?
> >
> > Perl?
> >
> > Groff?
> >
> > Gcc?
> >
> > See a pattern here?
>
> Yeah, the output of these programms are usually parsed by other programs.

s/usually/sometimes/

Most of the time, it's only parsed by humans, with the possible exception  
of awk.

But feel free to look for other common Unix programs that behave  
differently. df, du, ps, ls, bash ... there *are* programs that announce  
the copyright at the start, but there are damned few of them. It's not in  
the culture.

> If they barked version info, that'd be extra code that has to go into
> *EVERY* script that uses them. You're not using the kernel in the same
> capacity.

OTOH, kernel output typically *always* goes into another program (dmesg,  
klog, syslog) ... though admittedly parsing it is not common. Well, except  
for the oops part (klogd, ksymoops).

MfG Kai
