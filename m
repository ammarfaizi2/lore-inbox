Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283656AbRLDOo3>; Tue, 4 Dec 2001 09:44:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283664AbRLDOm7>; Tue, 4 Dec 2001 09:42:59 -0500
Received: from eispost12.serverdienst.de ([212.168.16.111]:47376 "EHLO imail")
	by vger.kernel.org with ESMTP id <S284312AbRLDOGc>;
	Tue, 4 Dec 2001 09:06:32 -0500
Content-Type: text/plain; charset=US-ASCII
From: Robert Szentmihalyi <robert.szentmihalyi@entracom.de>
To: Jason L Tibbitts III <tibbs@math.uh.edu>,
        "Neulinger, Nathan" <nneul@umr.edu>
Subject: Re: Problems with 3ware 3dm and 2.4.16...
Date: Tue, 4 Dec 2001 15:06:09 +0100
X-Mailer: KMail [version 1.3.2]
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux@3ware.com'" <linux@3ware.com>+
In-Reply-To: <E8139C9A62384F49A7EBF9CCCD2243C101B88A@umr-mail2.umr.edu> <ufavgfvtnrm.fsf@epithumia.math.uh.edu>
In-Reply-To: <ufavgfvtnrm.fsf@epithumia.math.uh.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200112041507280.SM00162@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 28. November 2001 07:25 schrieb Jason L Tibbitts III:
> >>>>> "NN" == Nathan Neulinger <Neulinger> writes:
>
> NN> When running 2.4.10, everything works fine, as soon as I move
> to NN> 2.4.16 though, the 3ware 3dm process no longer works, it
> claims to NN> get a ioctl error 'no such device or address'.
> Interesting thing NN> is - from the below output, looks like the
> ioctl worked.
>
> Which version of 3dm are you running?  Rumour has it (on
> linux-ide-arrays@lists.math.uh.edu) that 3dm version 1.10 will
> solve this problem.  I have not yet upgraded my storage machines,

I have just set up 3dmd on a SuSE Linux 7.3 file server with kernel 
2.4.15-pre7-xfs (from the XFS CVS tree) and get exactly the ioctl 
error Nathan described with the web interface saying "Error: No 
Controllers Found".
3dmd reports version 1.10.00.020, so the problem doesn't seem to be 
fixed.

I set up a similar server with SuSE Linux 7.2 and kernel 
2.4.15-pre7-xfs a while back, which causes no such problems.

Nathan, did you get any reply from 3ware support so far?
I have CC'd them again...

> however. Perhaps tomorrow.
It doesn't seem to be worh it... :-(

>
>  - J<

Robert

-- 
Where do you want to be tomorrow?

Entracom. Building Linux systems.
http://www.entracom.de
