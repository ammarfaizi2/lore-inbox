Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261944AbSIPOA2>; Mon, 16 Sep 2002 10:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261952AbSIPOA2>; Mon, 16 Sep 2002 10:00:28 -0400
Received: from users.linvision.com ([62.58.92.114]:41882 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S261944AbSIPOA0>; Mon, 16 Sep 2002 10:00:26 -0400
Date: Mon, 16 Sep 2002 16:05:13 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Larry McVoy <lm@bitmover.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
Message-ID: <20020916160513.A14649@bitwizard.nl>
References: <E17qRfU-0001qz-00@starship> <Pine.LNX.4.44.0209151103170.10830-100000@home.transmeta.com> <20020915190435.GA19821@nevyn.them.org> <20020915162412.A17345@work.bitmover.com> <20020915234108.GA1348@nevyn.them.org> <20020915165235.B17345@work.bitmover.com> <1032139750.26911.20.camel@irongate.swansea.linux.org.uk> <20020915191318.C22354@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020915191318.C22354@work.bitmover.com>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 15, 2002 at 07:13:18PM -0700, Larry McVoy wrote:
> the code would have fixed it already?  It's almost never as simple as a
> naive point of view thinks it is and that's exactly why you don't want
> people hacking about in that code.  Either understand it and really fix
> it, own it, maintain it, live with it, or leave it alone.  

Sometimes people who maintain the code move on to other things. 

So, maintenance is sometimes required by people who do not have
"maintenance of this code" in their job description. When I'm paying
their salary, they get to fix other peoples code, even if it's none of
their business.

Now preferably such a fix would be passed through a maintainer who can
say (with his intimate knowledge of the code): "Oops, you're right
your patch is indeed an improvement".

If that's not possible, we'll have to make do with some testing.

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currenly in such an       * 
* excursion: The stable situation does not include humans. ***************
