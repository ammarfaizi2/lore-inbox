Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263594AbTJQTiC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 15:38:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbTJQTiB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 15:38:01 -0400
Received: from unthought.net ([212.97.129.88]:15278 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S263594AbTJQTh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 15:37:58 -0400
Date: Fri, 17 Oct 2003 21:37:57 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Software RAID5 with 2.6.0-test
Message-ID: <20031017193756.GH8711@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <1065690658.10389.19.camel@slurv> <Pine.LNX.3.96.1031017125544.24004C-100000@gatekeeper.tmr.com> <yw1xu167kbcw.fsf@users.sourceforge.net> <3F903768.7060803@rackable.com> <yw1xllrjk70f.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xllrjk70f.fsf@users.sourceforge.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 09:18:24PM +0200, Måns Rullgård wrote:
> Samuel Flory <sflory@rackable.com> writes:
...
> >    many clock cycles availble to it.  It's even worse when you realize
> >    the 2Ghz xeon is a better proccessor in many more ways than just
> >    clock cycles.
> 
> How about this logic:
> 
> 1) If the processor on the RAID controller can handle the full
> bandwidth of the disks, it's fast enough.
> 2) If someone else does the 10% work, the CPU can do 10% more work.

3) You have a four year old machine - one day the RAID controller dies.
   The company that produced it has been acquired by someone else, and
   the product is no longer availble.  Can you get a new adapter with
   firmware that can actually read your disks?   Or are your data lost?
   Can you find a replacement controller on e-bay?  And would you want
   to?


Anyway, not wanting to spread more FUD than stricly necessary: It's a
matter of cost/benefit and risk management.   Everyone has their
personal preferences on this - and even if it wasn't so, let's not
begin to pretend that there is a simple answer to what's "best".

-- 
................................................................
:   jakob@unthought.net   : And I see the elder races,         :
:.........................: putrid forms of man                :
:   Jakob Østergaard      : See him rise and claim the earth,  :
:        OZ9ABN           : his downfall is at hand.           :
:.........................:............{Konkhra}...............:
