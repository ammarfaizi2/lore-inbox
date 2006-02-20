Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932662AbWBTTub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932662AbWBTTub (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 14:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932665AbWBTTub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 14:50:31 -0500
Received: from styx.suse.cz ([82.119.242.94]:47776 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932662AbWBTTua (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 14:50:30 -0500
Date: Mon, 20 Feb 2006 20:50:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Pavel Machek <pavel@suse.cz>
Cc: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>,
       Nishanth Aravamudan <nacc@us.ibm.com>, Nick Warne <nick@linicks.net>,
       Jesper Juhl <jesper.juhl@gmail.com>, ghrt@dial.kappa.ro, perex@suse.cz,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: No sound from SB live!
Message-ID: <20060220195036.GA31213@suse.cz>
References: <20060218231419.GA3219@elf.ucw.cz> <9a8748490602190304w43c32ae6m5b610f2ec9ad46f2@mail.gmail.com> <7c3341450602190318o1c60e9b5w@mail.gmail.com> <20060219205157.GA5976@us.ibm.com> <1140384638.2733.389.camel@mindpipe> <20060219214934.GO15311@elf.ucw.cz> <1140386075.2733.399.camel@mindpipe> <20060219222533.GB15608@elf.ucw.cz> <s5hzmkm1dtl.wl%tiwai@suse.de> <20060220114129.GA16165@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220114129.GA16165@elf.ucw.cz>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 12:41:29PM +0100, Pavel Machek wrote:

> > If you hear something, it's definitely a mixer configuration problem,
> > maybe screwed up by some reason.  In such a case, it's easier to
> > re-initialize from the scratch:
> 
> It may me EMI or something like that. I can hear something but it is
> so faint I'm not sure if I'm not hearing power drawn from CPU.

My Live! died some time ago with similar symptoms. I had a second one so
I could verify it's the hardware and not a driver bug.

-- 
Vojtech Pavlik
Director SuSE Labs
