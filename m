Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262290AbTGFNDZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 09:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTGFNDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 09:03:25 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:30985 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S262290AbTGFNDY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 09:03:24 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Russell King <rmk@arm.linux.org.uk>
Subject: Re: yenta-socket oops with 2.5.73-mm3, 2.5.74, 2.5.74-mm1
Date: Sun, 6 Jul 2003 21:14:13 +0800
User-Agent: KMail/1.5.2
Cc: Daniel Ritz <daniel.ritz@gmx.ch>, Dominik Brodowski <linux@brodo.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-pcmcia <linux-pcmcia@lists.infradead.org>
References: <200307060039.34263.daniel.ritz@gmx.ch> <200307061126.34635.mflt1@micrologica.com.hk> <20030706084524.A8146@flint.arm.linux.org.uk>
In-Reply-To: <20030706084524.A8146@flint.arm.linux.org.uk>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307062114.16117.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 06 July 2003 15:45, Russell King wrote:
> On Sun, Jul 06, 2003 at 11:26:34AM +0800, Michael Frank wrote:
> > I got the patch below (not yet tested) from Dominik.
>
> I've already thrown this one out and suggested a cleaner alternative to
> Dominik.
>

I await the new patch then, 

> I was busy wasting time trying to get an XScale platform up and running
> yesterday, and getting nowhere fast.  Going nowhere at all is a very
> accurate description of yesterdays activities.  I suspect the hardware
> may have been messed up during transit thanks to various screws missing.

Hopefully Monday will be a better day...

Regards
Michael

-- 
Powered by linux-2.5.74-mm1. Compiled with gcc-2.95-3 - mature and rock solid

My current linux related activities:
- 2.5 yenta_socket testing
- Test development and testing of swsusp and ACPI S3
- Everyday usage of 2.5 kernel

More info on 2.5 kernel: http://www.codemonkey.org.uk/post-halloween-2.5.txt

