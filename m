Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbRDPOxd>; Mon, 16 Apr 2001 10:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132142AbRDPOxX>; Mon, 16 Apr 2001 10:53:23 -0400
Received: from relay.freedom.net ([207.107.115.209]:7685 "HELO relay")
	by vger.kernel.org with SMTP id <S132146AbRDPOxO>;
	Mon, 16 Apr 2001 10:53:14 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQFaD9VqN50E5BX68SfjNo4w6J6Y3HOK9iMYpwU5eHu/ge4hMvhU6aFE
Date: Mon, 16 Apr 2001 08:51:57 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: Marko Kreen <marko@l-t.ee>
CC: linux-kernel@vger.kernel.org
Subject: Re: DPT PM3755F Fibrechannel Host Adapter
In-Reply-To: <20010414233426Z131976-682+268@vger.kernel.org> <20010415020433.B13190@l-t.ee>
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010416145319Z132146-682+540@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Marko.  This was exactly what I was looking for.  And thank you very much Omar Kilani for the retrofit.  But kernel doesn't recognize the adapter.

Installed the patch, compiled, installed, & everything seemed to go fine.  Booted to IDE... no problems, except the DPT HA wasn't recognized.  There was no mention of the DPT in messages, either recognized as hardware, nor to load the driver.

I am running an MSI KT7Turbo mobo with Athlon 850.  Six PCI & no IDE.  DPT PM3755F fibrechannel host adapter is in the first slot & has two Cheetahs attached.  Outfit works fine in Winders2k.  Trying to move to kernel 2.4.2, in RedHat Wolverine.

Please help.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914


Marko Kreen wrote:

> On Sat, Apr 14, 2001 at 05:33:02PM -0600, cacook@freedom.net wrote:
> > I have been unable to set up a module for my DPT fibrechannel host adapter, partly through unavailability, and partly through inexperience.
>
> There is a nice suppary of current DPT driver status on Kernel
> Traffic #113:
>
> http://kt.zork.net/kernel-traffic/kt20010330_113.html#3
>
> --
> marko
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/




