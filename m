Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130133AbRAYKLw>; Thu, 25 Jan 2001 05:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130292AbRAYKLm>; Thu, 25 Jan 2001 05:11:42 -0500
Received: from zeus.kernel.org ([209.10.41.242]:44502 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S130133AbRAYKLa>;
	Thu, 25 Jan 2001 05:11:30 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200101250611.f0P6BI418581@devserv.devel.redhat.com> 
In-Reply-To: <200101250611.f0P6BI418581@devserv.devel.redhat.com> 
To: Alan Cox <alan@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patches 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 25 Jan 2001 10:08:02 +0000
Message-ID: <19765.980417282@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@redhat.com said:
>  I seem to be getting more and more patches that have tabs/spaces
> broken and line wrap damage. I've dumped a pile in my queue including
> some pcmcia support for sh3 and the like 

Note that pine 4.30 (shipped with Red Hat 7) has taken to stripping 
trailing whitespace from each line of a mail just before it sends it.

See http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=23679 for a patch, 
if you can get at it - I seem to be firewalled from it at the moment. 

This corruption still occurs in pine 4.32.

--
dwmw2


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
