Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313833AbSDQMi2>; Wed, 17 Apr 2002 08:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313854AbSDQMi1>; Wed, 17 Apr 2002 08:38:27 -0400
Received: from skunk.directfb.org ([212.84.236.169]:41665 "EHLO
	skunk.directfb.org") by vger.kernel.org with ESMTP
	id <S313833AbSDQMi0>; Wed, 17 Apr 2002 08:38:26 -0400
Date: Wed, 17 Apr 2002 14:37:56 +0200
From: Denis Oliver Kropp <dok@directfb.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: lkml <linux-kernel@vger.kernel.org>, xpert@XFree86.org,
        debian-user@debian.org, debian-x@debian.org
Subject: Re: SIS 315/550/650/640/740 - testers wanted
Message-ID: <20020417123756.GA17545@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <3CBC85FD.4A9BC7FB@winischhofer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Thomas Winischhofer (thomas@winischhofer.net):
> 
> Hi,
> 
> I am desperatly looking for people who are willing to help me testing
> (and eventually developing) the kernel framebuffer and X driver for
> these chipsets.
> 
> If you're interested, please drop me a note.

Hi,

I have a SIS 315 connected to a TV using it in PAL mode.
The driver produces kernel oopses sometimes, especially when
doing mode and VT switches. Also the TV out is broken for
some resolutions. I can do more testing and give you more
details if you want.

I am willing to test new driver versions and am also thinking
about writing an accelerated driver for DirectFB.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

                            Convergence GmbH
