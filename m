Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130151AbRBJArH>; Fri, 9 Feb 2001 19:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130438AbRBJAq6>; Fri, 9 Feb 2001 19:46:58 -0500
Received: from cheetah.STUDENT.CWRU.Edu ([129.22.164.229]:60800 "EHLO
	cheetah.STUDENT.cwru.edu") by vger.kernel.org with ESMTP
	id <S130151AbRBJAqw>; Fri, 9 Feb 2001 19:46:52 -0500
Date: Fri, 9 Feb 2001 19:46:31 -0500 (EST)
From: Matthew Gabeler-Lee <msg2@po.cwru.edu>
X-X-Sender: <cheetah@cheetah.STUDENT.cwru.edu>
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: bttv problems in 2.4.0/2.4.1
In-Reply-To: <Pine.LNX.4.21.0102091600320.26669-100000@sol.compendium-tech.com>
Message-ID: <Pine.LNX.4.33.0102091945290.4019-100000@cheetah.STUDENT.cwru.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Feb 2001, Dr. Kelsey Hudson wrote:

> Do you have framebuffer console compiled into your kernel? I noticed
> similar behavior on my system when I had framebuffer console compiled in,
> ACPI or APM (cant remember which, probably ACPI) compiled in, and bttv as
> modules. System would power off when ACPI was loaded. Other times it would
> do other stupid things like hang abruptly for no apparent reason.

My video card isn't really supported by the framebuffer stuff, at least
not for accelleration, so I don't have framebuffer support.  I have been
experiencing abrupt hangs recently too ...

-- 
	-Matt

If you suspect a man, don't employ him.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
