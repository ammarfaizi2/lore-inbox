Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274102AbRJIKsz>; Tue, 9 Oct 2001 06:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274964AbRJIKsf>; Tue, 9 Oct 2001 06:48:35 -0400
Received: from mail-01.med.umich.edu ([141.214.93.149]:19972 "EHLO
	mail-01.med.umich.edu") by vger.kernel.org with ESMTP
	id <S274102AbRJIKs1> convert rfc822-to-8bit; Tue, 9 Oct 2001 06:48:27 -0400
Message-Id: <sbc29e8b.006@mail-01.med.umich.edu>
X-Mailer: Novell GroupWise Internet Agent 6.0
Date: Tue, 09 Oct 2001 06:51:47 -0400
From: "Nicholas Berry" <nikberry@med.umich.edu>
To: <root@mauve.demon.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Odd keyboard related crashes.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>> Ian Stirling <root@mauve.demon.co.uk> 10/08/01 12:21PM >>>
> 
> Pavel Machek <pavel@suse.cz> writes:
> 
> > Hi!
> > 
> > > >>> Ian Stirling <root@mauve.demon.co.uk> 10/05/01 05:01AM >>>
> > > >I'm running 2.4.10, and the ps/2 keyboard came out of it's socket.

>I should possibly have mentioned that APM is enabled on this machine,
> but no suspend/standby had been done, it's only for use in power-cuts
> when I want to minimise draw from the UPS batteries.
> The machine is an athlon desktop.

> I'll see if I can reproduce this with 2.4.11, 2.4.10 is utterly unusable
> for me. (totally insane swapping out causing things to get killed on 
> significant reading.

I think you'll find it with any kernel. I still think this is normal behaviour. Unplugging the keyboard is fine, and should break nothing. Plugging it back it should not work. I guess I could try it on my machine here at work, but I'm not going to ;-).


