Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265808AbSKAW7q>; Fri, 1 Nov 2002 17:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265809AbSKAW7q>; Fri, 1 Nov 2002 17:59:46 -0500
Received: from nameservices.net ([208.234.25.16]:42349 "EHLO opersys.com")
	by vger.kernel.org with ESMTP id <S265808AbSKAW7p>;
	Fri, 1 Nov 2002 17:59:45 -0500
Message-ID: <3DC309D1.CF6659FB@opersys.com>
Date: Fri, 01 Nov 2002 18:10:09 -0500
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Werner Almesberger <wa@almesberger.net>
CC: David Lang <david.lang@digitalinsight.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
References: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com> <Pine.LNX.4.44.0211011218560.26353-100000@dlang.diginsite.com> <20021101192545.F2599@almesberger.net> <3DC30370.46637A01@opersys.com> <20021101195410.G2599@almesberger.net>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:
> Karim Yaghmour wrote:
> > Why not just have a simple backup stripped-down "hardened" copy of Linux
> > lying around in a physical RAM region not used by the copy of Linux
> > actually running.
> 
> Congratulations, you've just re-invented MCORE :-) That's exactly
> what they do on systems where rebooting through the firmware
> doesn't preserve RAM.

Oh well, can't have a freshmeat db in my head I guess ;) That said,
I like this approach since you don't need to care about new drivers
and so on ... but since it's already out there I guess it's
advantages have been covered elsewhere ...

Karim

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
