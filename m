Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277714AbRJLOfT>; Fri, 12 Oct 2001 10:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277716AbRJLOfJ>; Fri, 12 Oct 2001 10:35:09 -0400
Received: from borg.org ([208.218.135.231]:44294 "HELO borg.org")
	by vger.kernel.org with SMTP id <S277714AbRJLOev>;
	Fri, 12 Oct 2001 10:34:51 -0400
Date: Fri, 12 Oct 2001 10:35:22 -0400
From: Kent Borg <kentborg@borg.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kapm-idled Funny in 2.4.10-ac12?
Message-ID: <20011012103522.D19336@borg.org>
In-Reply-To: <20011012101242.C19336@borg.org> <E15s3CH-0007LG-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15s3CH-0007LG-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, Oct 12, 2001 at 03:21:57PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2001 at 03:21:57PM +0100, Alan Cox wrote:
> Is your laptop logging messages in the process ? (dmesg)

No.  I don't see any ongoing logging from apm.  Looking at dmesg I see
boot stuff about battery minutes having swapped bytes, some version
and flag printk's, but no current logging.

In /var/spool/messages I also see mention of the times I have
suspended and awakened my laptop, but no other ongoing loggin there
either.

> One thing I changed in -ac was to do sane things when the apm idle request
> comes back with "no" from the BIOS

I had noticed that comment, which made me think it might be of
specific interest.


Thanks,

-kb

