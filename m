Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261877AbTC0KD7>; Thu, 27 Mar 2003 05:03:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261886AbTC0KD6>; Thu, 27 Mar 2003 05:03:58 -0500
Received: from [81.80.245.157] ([81.80.245.157]:12431 "EHLO smtp.alcove-fr")
	by vger.kernel.org with ESMTP id <S261877AbTC0KD5>;
	Thu, 27 Mar 2003 05:03:57 -0500
Date: Thu, 27 Mar 2003 11:15:28 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Greg KH <greg@kroah.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: USB MemoryStick reader and 2.5.66
Message-ID: <20030327101527.GB4831@hottah.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
Mail-Followup-To: Stelian Pop <stelian.pop@fr.alcove.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030325124711.GC1242@hottah.alcove-fr> <20030326185817.GG24689@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030326185817.GG24689@kroah.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 26, 2003 at 10:58:17AM -0800, Greg KH wrote:

> No it should work.  I just used a usb cdrom successfully with 2.5.66.
> 
> > This is with an internal USB Memory Stick reader on a Sony Vaio C1VE, 

It doesn't work for me, with the memory stick reader or an external
usb floppy drive.

> > Is someone interesting in a more complete bug report or should I
> > test something else ?
> 
> Could you enter this into bugzilla.kernel.org?  Then I can assign it to
> the usb-storage maintainer :)

Sure, bug #510. ( http://bugme.osdl.org/show_bug.cgi?id=510 )

Thanks,

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
Alcove - http://www.alcove.com
