Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280979AbRKCQRb>; Sat, 3 Nov 2001 11:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280980AbRKCQRK>; Sat, 3 Nov 2001 11:17:10 -0500
Received: from nic-131-c196-222.mw.mediaone.net ([24.131.196.222]:14865 "EHLO
	moonweaver.awesomeplay.com") by vger.kernel.org with ESMTP
	id <S280979AbRKCQRE>; Sat, 3 Nov 2001 11:17:04 -0500
Subject: Re: Via onboard audio
From: Sean Middleditch <elanthis@awesomeplay.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1004723462.4883.12.camel@smiddle>
In-Reply-To: <E15zh4S-0002oT-00@the-village.bc.nu> 
	<1004723462.4883.12.camel@smiddle>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100 (Preview Release)
Date: 03 Nov 2001 11:21:33 -0500
Message-Id: <1004804493.8567.7.camel@stargrazer>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, OK, I downloaded 2.4.13-0.3 RPMs from Rawhide (ya, I'm a wuss, oh
well) and it didn't like my laptop at all.

Sound did work somewhat better...  XMMS didn't skip and freeze, and
cat'ing a wav to /dev/dsp didn't finish immediately (looked like it was
taking time to play, actually), but I still heard no sound.  I *did*
check the mixer, and all the relevant devices are right on up there.

HOwever, 2.4.13 started freaking on me.  My project I was working on
ceased to compile (gcc kept crashing, which it didn't do on 2.4.12), and
when I shut down the machine to reboot into 2.4.12, I saw a bunch of
kernel oops error message, the first of which was the VM, which had
decided to kill "sh".

In any event, I have no clue how to debug a kernel properly properly, so
I don't know what more to say.  Perhaps someone can give me some
pointers?  Or this is a known issue that has aready been rectified?

BTW, I won't be on the list much longer, the traffic is killer.  ~,^  So
please make sure CC's or whatnot have me in them.

Thanks,
Sean Etc.

On Fri, 2001-11-02 at 12:51, Sean Middleditch wrote:
> OK, will do that.  RedHat uses your kernel trees, right?  I'll download
> new RPM's from rawhide if they're there (I'm in no hurry.)
> 
> Thanks!
> Sean Etc.
> 
> On Fri, 2001-11-02 at 11:21, Alan Cox wrote:
> > Try the current 2.4.13-ac ones - there are some via audio updates there
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


