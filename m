Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRDBRp7>; Mon, 2 Apr 2001 13:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131226AbRDBRpu>; Mon, 2 Apr 2001 13:45:50 -0400
Received: from virtualro.ic.ro ([194.102.78.138]:10000 "EHLO virtualro.ic.ro")
	by vger.kernel.org with ESMTP id <S131205AbRDBRpk>;
	Mon, 2 Apr 2001 13:45:40 -0400
Date: Mon, 2 Apr 2001 20:44:14 +0300 (EEST)
From: Jani Monoses <jani@virtualro.ic.ro>
To: Harald Dunkel <harri@synopsys.COM>
cc: linux-kernel@vger.kernel.org
Subject: Re: VIA 82C686 Audio Codec: Clicks
In-Reply-To: <3AC6DA1E.3332962D@Synopsys.COM>
Message-ID: <Pine.LNX.4.10.10104022042170.24643-100000@virtualro.ic.ro>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



You could try the ALSA driver if you're certain it is not a hw problem.It
works better here than the one in the kernel.

On Sun, 1 Apr 2001, Harald Dunkel wrote:

> Hi folks,
> 
> Has anybody an idea how to get rid of the annoying clicks of the
> VIA 82C686 audio codec? Using xmms (just as an example) I get a 
> click with each new track, when I move and release the track slider, 
> etc.
> 
> Even this
> 
> 	echo -n "" >/dev/dsp
> 
> produces a click.
> 
> 
> Regards
> 
> Harri
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

