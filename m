Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750978AbWBSGGN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWBSGGN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Feb 2006 01:06:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWBSGGN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Feb 2006 01:06:13 -0500
Received: from ms-smtp-05-smtplb.tampabay.rr.com ([65.32.5.135]:3460 "EHLO
	ms-smtp-05.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S1750967AbWBSGGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Feb 2006 01:06:12 -0500
Message-ID: <43F80ACC.20704@cfl.rr.com>
Date: Sun, 19 Feb 2006 01:06:04 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060119)
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
CC: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: Flames over -- Re: Which is simpler?
References: <200602131116.41964.david-b@pacbell.net> <43F0E724.6000807@cfl.rr.com> <20060215234317.GC3490@openzaurus.ucw.cz> <200602181251.09865.david-b@pacbell.net>
In-Reply-To: <200602181251.09865.david-b@pacbell.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Brownell wrote:
> 
> Hardware is CORRECTLY reporting electrical disconnects,
> but Philip is wanting Linux to ignore those reports.
> 
> 

No, not ignore, just realize that an electrical disconnection does not 
necessarily mean that the volume can no longer be accessed.

> 
> No patch possible.  Reading the other messages in that
> thread, Philip is advocating Linux ignore the USB spec.
> (Which is what _he_ appears to have been doing...)
> 

Non sequitur.  The USB spec does not say the kernel must force unmount 
the drive.

> What he has to do is more than submit a patch.  He first
> needs to lobby the USB-IF to change the USB spec, and
> get every peripheral vendor to stop shipping USB devices
> and instead switch over to "Philip-USB".  Then get all
> the billions of USB peripherals to go into the recycle
> bin and be replaced with products conforming to his
> new variant.  It all seems highly unlikely.  ;)
> 
> 
> But yes, you're right ... if he's serious about
> changing all that stuff, he also needs stop being a
> member of the "never submitted a USB patch" club.
> Ideally, starting with small things.
> 


You're moving off into left field.

