Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265801AbSKAWr6>; Fri, 1 Nov 2002 17:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265802AbSKAWr6>; Fri, 1 Nov 2002 17:47:58 -0500
Received: from almesberger.net ([63.105.73.239]:38152 "EHLO
	host.almesberger.net") by vger.kernel.org with ESMTP
	id <S265801AbSKAWr5>; Fri, 1 Nov 2002 17:47:57 -0500
Date: Fri, 1 Nov 2002 19:54:10 -0300
From: Werner Almesberger <wa@almesberger.net>
To: Karim Yaghmour <karim@opersys.com>
Cc: David Lang <david.lang@digitalinsight.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lkcd-general@lists.sourceforge.net, lkcd-devel@lists.sourceforge.net
Subject: Re: What's left over.
Message-ID: <20021101195410.G2599@almesberger.net>
References: <Pine.LNX.4.44.0211011107470.4673-100000@penguin.transmeta.com> <Pine.LNX.4.44.0211011218560.26353-100000@dlang.diginsite.com> <20021101192545.F2599@almesberger.net> <3DC30370.46637A01@opersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC30370.46637A01@opersys.com>; from karim@opersys.com on Fri, Nov 01, 2002 at 05:42:56PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Karim Yaghmour wrote:
> Why not just have a simple backup stripped-down "hardened" copy of Linux
> lying around in a physical RAM region not used by the copy of Linux
> actually running.

Congratulations, you've just re-invented MCORE :-) That's exactly
what they do on systems where rebooting through the firmware
doesn't preserve RAM.

- Werner

-- 
  _________________________________________________________________________
 / Werner Almesberger, Buenos Aires, Argentina         wa@almesberger.net /
/_http://www.almesberger.net/____________________________________________/
