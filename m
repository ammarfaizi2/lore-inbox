Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVCCTs1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVCCTs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 14:48:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261599AbVCCTqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:46:19 -0500
Received: from rproxy.gmail.com ([64.233.170.193]:31236 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261597AbVCCTmg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:42:36 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=OZ7U7N+P/36gAtu+AI5srw/pQgapRr5a+WFoFJATvToPPl2Vrqd7xNGA+VBovsZKiph5eS4mEiwjYBL6NyQut9cGfn5EEZdwoLiFdwlElngm2RxIKOxGOpWwcG2hWfm5E3aOmtiCC2mzEK06Z4QKLK4YVp1NkK3PB4HJCrarsKc=
Message-ID: <29495f1d05030311423f4c1ebc@mail.gmail.com>
Date: Thu, 3 Mar 2005 11:42:30 -0800
From: Nish Aravamudan <nish.aravamudan@gmail.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
To: Mark Canter <marcus@vfxcomputing.com>
Subject: Re: [Alsa-devel] Re: intel 8x0 went silent in 2.6.11
Cc: Lee Revell <rlrevell@joe-job.com>, Pierre Ossman <drzeus-list@drzeus.cx>,
       LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <1109875926.2908.26.camel@mindpipe>
	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 3 Mar 2005 14:06:38 -0500 (EST), Mark Canter
<marcus@vfxcomputing.com> wrote:
> 
> Correct, but if you want to use your headphones you would have to enable
> headphones on your mixer, which would negate your speaker output through
> your docking station's output.  If you want to use the docking station
> speakers, you would have to disable the headphones in order to get the
> docking station speakers to work; no?  If that is the case, then you would
> still have to enable/disable each time you wanted to change the direction
> of headphones/external speakers.  Again, this is not the case under <=
> 2.6.10 where it works regardless of enabling/disabling headphones.

I am not seeing this behavior. The Sense alsamixer entries do not to
be toggled ever again once they have been muted (for me, at least).
Both the t41p speakers and headphone jack work (with the speakers
being muted when headphones are plugged in).

Thanks,
Nish
