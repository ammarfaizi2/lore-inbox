Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281042AbRKOUfS>; Thu, 15 Nov 2001 15:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281040AbRKOUfJ>; Thu, 15 Nov 2001 15:35:09 -0500
Received: from mout0.freenet.de ([194.97.50.131]:41919 "EHLO mout0.freenet.de")
	by vger.kernel.org with ESMTP id <S281042AbRKOUfA>;
	Thu, 15 Nov 2001 15:35:00 -0500
Message-ID: <3BF425E1.B487225F@mailnet.de>
Date: Thu, 15 Nov 2001 21:30:25 +0100
From: pil@mailnet.de
X-Mailer: Mozilla 4.78C-pil. [en] (X11; U; Linux 2.4.10 i586)
X-Accept-Language: en, en-US, de
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: HFS-Bug in Kernel 2.4.12 and above
In-Reply-To: <3BF3DB8A.CD1BBCE6@mailnet.de> <20011115152636.A1259@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Thu, Nov 15, 2001 at 04:13:14PM +0100, pil@mailnet.de wrote:
> > Kernel 2.4.12 is no more able to handle two floppy drives with hfs
> > formated floppies.
> >
> > You can recreate the failure if you have two floppy drives, use Kernel
> > 2.4.12 (and above) with loadable module support for hfs- and
> > vfat-floppies and try to mount the first one with a hfs formated floppy
> > inside. If you unmount the floppy drive again you will get a
> > segmentation fault and an uninterruptible sleep for the mount PID. You
> > cannot mount this drive again.
> >
> > For all other see attached file 'report'.
> >
> > Regards
> >
> > Wolfgang Pichler
> > ARM MFM AND FLOPPY DRIVERS
> > P:      Dave Gilbert
> > M:      linux@treblig.org
> > S:      Maintained
> >
> 
> What is the relevance of the above past from the Linux CREDITS file?
> 

Sorry, no relevence at all. Dave Gilbert was the first to whom the
bug-report was sent.

Regards

Wolfgang Pichler

