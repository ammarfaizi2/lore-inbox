Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262854AbVBCP3i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262854AbVBCP3i (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 10:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbVBCP3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 10:29:38 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:34428 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263795AbVBCP27 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 10:28:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=U1maC61ZRZLuvGU7MW8tjnDVn3jqLdfWIK7KgeZWLpKlvs5gEwA1OhrmE4olC1Qj2ZC7aRBuLzVT7l9Ncvn4tRgMe4m4WQGtO+jD1aeIKRjFflN89AlbOntsquvwTvRvRtfST3uDggADr/oFkFek5AIyZ/l2McWhA7bItSzPUvo=
Message-ID: <d120d50005020307285a8e07cd@mail.gmail.com>
Date: Thu, 3 Feb 2005 10:28:58 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Alexandre Oliva <aoliva@redhat.com>
Subject: Re: Touchpad problems with 2.6.11-rc2
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pete Zaitcev <zaitcev@redhat.com>,
       Peter Osterlund <petero2@telia.com>, linux-kernel@vger.kernel.org
In-Reply-To: <orwttpad0e.fsf@livre.redhat.lsd.ic.unicamp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050123190109.3d082021@localhost.localdomain>
	 <m3acqr895h.fsf@telia.com>
	 <20050201234148.4d5eac55@localhost.localdomain>
	 <20050202102033.GA2420@ucw.cz>
	 <20050202085628.49f809a0@localhost.localdomain>
	 <20050202170727.GA2731@ucw.cz>
	 <20050202095851.27321bcf@localhost.localdomain>
	 <or4qgurqp5.fsf@livre.redhat.lsd.ic.unicamp.br>
	 <20050203084900.GA2594@ucw.cz>
	 <orwttpad0e.fsf@livre.redhat.lsd.ic.unicamp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 03 Feb 2005 07:22:40 -0800 (PST), Alexandre Oliva
<aoliva@redhat.com> wrote:
> On Feb  3, 2005, Vojtech Pavlik <vojtech@suse.cz> wrote:
> 
> > On Thu, Feb 03, 2005 at 06:30:14AM -0200, Alexandre Oliva wrote:
> >> On Feb  2, 2005, Pete Zaitcev <zaitcev@redhat.com> wrote:
> >>
> >> > On Wed, 2 Feb 2005 18:07:27 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >>
> >> >> With a Synaptics I suppose? You wouldn't like it with an ALPS.
> >>
> >> > No, it's a Dualpoint, and so ALPS.
> >>
> >> Err...  That doesn't follow.  My Dell Inspiron 8000 has a Synaptics
> >> touchpad as part of the Dualpoint pointing devices.
> 
> > Dualpoint (tm) is a trademark of ALPS,
> 
> Interesting...  Dell DualPoint is the way the pointing devices are
> described in that notebook's documentation, and I remember all the way
> from back when I purchased the notebook: I really wanted the two
> pointing devices.  If you search the web for Dell Inspiron 8000
> DualPoint, you'll get a number of hits referring to `Dell's DualPoint
> technology'.  I don't see them referred to as DualPoint(TM), but I
> vaguely remember having seen something like that in Dell's web site
> back then.
> 
> Maybe ALPS bought the trademark from Dell, or Dell hadn't actually
> registered the trademark, or they somehow managed to get the
> trademarks registered with a case difference (DualPoint vs Dualpoint)?
> 

I am not sure but on this page ALPS states that they have trademark on
DualPoint (TM):

http://www3.alps.co.jp/cgi-bin/WebObjects/catalog.woa/wa/varietyList?language=english&country=com&top_mode=2003&productId=11&varietyId=3

-- 
Dmitry
