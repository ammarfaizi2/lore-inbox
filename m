Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271289AbRHOQm5>; Wed, 15 Aug 2001 12:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271283AbRHOQms>; Wed, 15 Aug 2001 12:42:48 -0400
Received: from mail.nep.net ([12.23.44.24]:59916 "HELO nep.net")
	by vger.kernel.org with SMTP id <S271285AbRHOQmh>;
	Wed, 15 Aug 2001 12:42:37 -0400
Message-ID: <19AB8F9FA07FB0409732402B4817D75A038A6A@FILESERVER.SRF.srfarms.com>
From: "Ryan C. Bonham" <Ryan@srfarms.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Via chipset
Date: Wed, 15 Aug 2001 12:46:19 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan,

Is anyone keeping a list of which boards with VIA chipsets are having
problems, and which aren't.. Or is the problem more random then that, like
some Abit board work and some don't??  If there is a list, would someone
send it to me.. I am interested in trying to help debug this problem, and I
need to know what boards I should test this out on.. 

Thanks

Ryan

> -----Original Message-----
> From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
> Sent: Wednesday, August 15, 2001 12:10 PM
> To: bdbryant@mail.utexas.edu
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: Via chipset
> 
> 
> > Alan Cox wrote:
> > > We know it happens on some boards that apparently cant 
> keep up. We dont know
> > > why, there is no time estimate for a cure. That 
> unfortunately is about it
> > 
> > FWIW (qualitative data point), my EPoX system with the VIA 
> chipset seems to run a
> > few *hours* without an oops when I boot a PIII kernel and 
> run it with X, but a few
> > *days* on the same kernel when I don't start X.
> > 
> > Sometimes it barfs early even without X, but there seems to 
> be a significant
> > difference in the expected uptime between using X and not using X.
> 
> If you are running XFree servers then provide info on the 
> card, the machine
> configuration and XFree version, whether you use DRI or not. 
> Also send the
> same info to XFree86 themselves. It's entirely possible the Xserver is
> the trigger some of the bugs, and getting the info to both 
> parties will
> really help
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
