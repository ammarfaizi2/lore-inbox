Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750766AbWANTES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWANTES (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 14:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750769AbWANTES
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 14:04:18 -0500
Received: from smtp-send.myrealbox.com ([151.155.5.143]:53456 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S1750766AbWANTES (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 14:04:18 -0500
From: Matthew Marshall <lists@matthewmarshall.org>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: PROBLEM: PCI WiFi card works with livecd's but not with HD install with Ali mobo.
Date: Sat, 14 Jan 2006 16:05:34 -0300
User-Agent: KMail/1.9.1
References: <200601141427.36915.matthew@matthewmarshall.org> <200601141445.49962.matthew@matthewmarshall.org> <1137260799.1408.58.camel@mindpipe>
In-Reply-To: <1137260799.1408.58.camel@mindpipe>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601141605.34891.lists@matthewmarshall.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 January 2006 14:46, you wrote:
> On Sat, 2006-01-14 at 14:45 -0300, Matthew Marshall wrote:
> > On Saturday 14 January 2006 14:37, you wrote:
> > > We can't help you with proprietary drivers on this list.  Can you
> > > reproduce the problem with no proprietary drivers loaded?
> >
> > I have a PCI Ethernet card I'll try with.
> >
> > Since bother drivers had the same result, and they both worked fine with
> > another mobo, I thought it was a problem with the drivers for the mobo. 
> > But, I'll see if I get the same result with an untainted kernel.

I tried it with both an Ethernet adapter (realtek) and a pci sound card 
(Creative SoundBlaster.)  The Ethernet adapter works fine with both live-cd 
(slax) and hd-install (archlinux) but I can't get the the soundcard to work 
with alsa on archlinux.  However, as it does play when using /dev/dsp2 
strait, this is possibly a different problem.

I guess I'll go ask on the madwifi mailing list.  Sorry about the noise...

> Anyone know why the MadWifi site does not say up front in big letters
> that it's just a GPL'ed wrapper around a proprietary HAL?  To read the
> Wiki you would think it's open source...

My guess is that they're not to proud of that detail...

Any way, I had forgotten about that.  I suppose my 'same results with two 
different drivers' reasoning melts away with that.

Thanks,
        Matthew Marshall
