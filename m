Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292784AbSBVEAv>; Thu, 21 Feb 2002 23:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292774AbSBVEAc>; Thu, 21 Feb 2002 23:00:32 -0500
Received: from gear.torque.net ([204.138.244.1]:28166 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S292761AbSBVEA3>;
	Thu, 21 Feb 2002 23:00:29 -0500
Message-ID: <3C75C264.80089312@torque.net>
Date: Thu, 21 Feb 2002 23:00:36 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net>
CC: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Compile error with linux-2.5.5-pre1 & advansys scsi
In-Reply-To: <3C6C579F.960DE0D7@torque.net> <200202212336.33831.gjwucherpfennig@gmx.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Gerold J. Wucherpfennig" wrote:
> 
> On Friday 15 February 2002 01:34, Douglas Gilbert wrote:
> > "Gerold J. Wucherpfennig" <gjwucherpfennig@gmx.net> wrote:
> > > The advansys scsi driver of linux-2.5.5-pre1 doesn't compile ...
> >
> > Gerold,
> > Please try the attachment, tested on i386 UP + SMP.
> >
> > Doug Gilbert
> 
> This patch works very well for me and it's a pitty that it wasn't included
> into Kernel 2.5.5-final.
> 
> I'm using advansys scsi with my P2 UP (Intel LX).
> 
> It should be included into Dave Jones tree (or is it already?),

The advansys patch is in patch-2.5.5-dj1 .

> because Linus seems to be very busy (as usual).

Doug Gilbert
