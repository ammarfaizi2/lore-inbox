Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbRBUWo2>; Wed, 21 Feb 2001 17:44:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129754AbRBUWoS>; Wed, 21 Feb 2001 17:44:18 -0500
Received: from pop.gmx.net ([194.221.183.20]:46747 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S129183AbRBUWoL>;
	Wed, 21 Feb 2001 17:44:11 -0500
Message-ID: <3A9445EE.CD6C97B1@gmx.at>
Date: Wed, 21 Feb 2001 23:49:18 +0100
From: rayn <Wilfried.Weissmann@gmx.at>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Jackson <jeremy.jackson@sympatico.ca>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: partitions for RAID volumes?
In-Reply-To: <3A942AEC.4004DA3F@gmx.at> <3A942C1E.6E539E5F@sympatico.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Jackson wrote:
> 
> rayn wrote:
> 
> > Hi,
> >
> > Is there any chance that RAID volumes would support partitions like the
> > hard-disk driver in the future? This could be handsome if you try to
> 
> You may wish to try LVM in kernel 2.4.0.  This is much more flexible
> for administration, but I don't know about windoze...

I agree. I know LVM from HP-UX and it works absolutely flawless there.
But when it comes to dualbooting several OSes like Linux and Win* I do
not think that you have a chance with LVM (unless all OSes support the
same LVM standard. Microsoft pops in my mind!).

Wilfried Weissmann
