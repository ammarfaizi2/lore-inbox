Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265205AbTBOVXW>; Sat, 15 Feb 2003 16:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265211AbTBOVXW>; Sat, 15 Feb 2003 16:23:22 -0500
Received: from mrw.demon.co.uk ([194.222.96.226]:40832 "HELO mrw.demon.co.uk")
	by vger.kernel.org with SMTP id <S265205AbTBOVXV> convert rfc822-to-8bit;
	Sat, 15 Feb 2003 16:23:21 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.61 and ELSA Passive Isdn cards...
Date: Sat, 15 Feb 2003 21:33:22 +0000
User-Agent: KMail/1.4.3
References: <Pine.LNX.4.44.0302151349570.30618-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0302151349570.30618-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302152106.54102.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 Feb 2003 7:50 pm, Kai Germaschewski wrote:
> On Sat, 15 Feb 2003, Mark Watts wrote:
> > make && make modules_install appear to work fine, but the last thing I
> > see before being dumped back to the prompt is this:
> >
> > WARNING: /lib/modules/2.5.61/kernel/drivers/isdn/hisax/hisax.ko needs
> > unknown symbol kstat__per_cpu
>
> It's a known problem and on my list to fix. Unfortunately, fixing it
> properly isn't entirely trivial.
>
> --kai
>

Good to know it's not me (for once :)

If you want an extra tester for any fixes, give me a shout.


Cheers,

Mark.


