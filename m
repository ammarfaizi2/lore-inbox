Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265116AbUADVvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 16:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUADVvs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 16:51:48 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:6632 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265116AbUADVvr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 16:51:47 -0500
Date: Sun, 4 Jan 2004 22:51:28 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dave Jones <davej@redhat.com>, Rob Love <rml@ximian.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, szepe@pinerecords.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Pentium M config option for 2.6
Message-ID: <20040104215128.GA14982@ucw.cz>
References: <200401041227.i04CReNI004912@harpo.it.uu.se> <1073228608.2717.39.camel@fur> <20040104162516.GB31585@redhat.com> <1073233988.5225.9.camel@fur> <20040104165028.GC31585@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040104165028.GC31585@redhat.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 04:50:28PM +0000, Dave Jones wrote:
> On Sun, Jan 04, 2004 at 11:33:08AM -0500, Rob Love wrote:
> 
>  > Yah.  I was just answering in the abstract to the "does cache line
>  > matter on non-SMP" question.
>  > 
>  > I actually like this patch (perhaps since I have a P-M :) and think it
>  > ought to go in, although I agree with others that the P-M is more of a
>  > super-P3 than a scaled down P4.
> 
> FWIW, I agree with it too on the grounds that its non obvious the optimal
> setting is CONFIG_MPENTIUMIII. This seems cleaner IMO than changing the
> helptext to read...
> 
>  "Pentium II"
>  "Pentium III / Pentium 4M"
>  "Pentium 4"
> 
> My other mail may have sounded like I objected to the patch per se, I don't.

Pentium M and Pentium 4M are two different beasts, by the way.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
