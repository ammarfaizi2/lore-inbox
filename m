Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281933AbRKZRPU>; Mon, 26 Nov 2001 12:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281934AbRKZRPK>; Mon, 26 Nov 2001 12:15:10 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:58120 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S281933AbRKZRPA>; Mon, 26 Nov 2001 12:15:00 -0500
Message-Id: <4.3.2.7.2.20011126120940.00b41b20@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Mon, 26 Nov 2001 12:14:57 -0500
To: lkml <linux-kernel@vger.kernel.org>
From: David Relson <relson@osagesoftware.com>
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.n
 et>
In-Reply-To: <Pine.LNX.4.21.0111261328450.13681-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:22 PM 11/26/01, Chris Meadors wrote:

>Aren't all the -pre's pre-finals?  And what if there is a big bug found in
>the -final, it will obviously be followed up with a -final-final?
>
>I like the ISC's release methods.  The do -rc's (-pre's would be fine for
>the kernel as it is already established), each -rc fixes problems found
>with the previous.  When an -rc has been out long enough with no more bug
>reports they release that code, WITHOUT changes.
>
>-Chris

Chris,

I think of -pre releases as beta code - testable and likely broken.  An -rc 
release would be "possibly broken".  If problems are encountered, fix ONLY 
those problems to generate the next -rc.  If it's O.K., then make it "final".

David


