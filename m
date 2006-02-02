Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWBBOqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWBBOqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 09:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWBBOqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 09:46:03 -0500
Received: from vms046pub.verizon.net ([206.46.252.46]:14052 "EHLO
	vms046pub.verizon.net") by vger.kernel.org with ESMTP
	id S1751095AbWBBOqB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 09:46:01 -0500
Date: Thu, 02 Feb 2006 09:45:59 -0500
From: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: GPL V3 and Linux - Dead Copyright Holders
In-reply-to: <43E1D2D0.2060105@drzeus.cx>
To: linux-kernel@vger.kernel.org
Reply-to: gene.heskett@verizon.net
Message-id: <200602020946.00161.gene.heskett@verizon.net>
Organization: Absolutely none - usually detectable by casual observers
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
Content-disposition: inline
References: <Pine.LNX.4.40.0601280826160.29965-100000@jehova.dsm.dk>
 <Pine.LNX.4.64.0602020044520.21884@g5.osdl.org> <43E1D2D0.2060105@drzeus.cx>
User-Agent: KMail/1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 02 February 2006 04:37, Pierre Ossman wrote:
>Linus Torvalds wrote:
>> On Thu, 2 Feb 2006, Pierre Ossman wrote:
>>> The point is not only getting access to the source code, but also
>>> being able to change it. Being able to freely study the code is
>>> only half of the beauty of the GPL. The other half, being able to
>>> change it, can be very effectively stopped using DRM.
>>
>> No it cannot.
>>
>> Sure, DRM may mean that you can not _install_ or _run_ your changes
>> on somebody elses hardware. But it in no way changes the fact that
>> you got
>
>I don't consider things I've bought to be somebody elses hardware. The
>whole attitude of the big manufacturer that kindly gives me permission
>to use their product only how they see fit is very disgusting to me.
>
>> The difference? The hardware may only run signed kernels. The fact
>> that the hardware is closed is a _hardware_ license issue. Not a
>> software license issue. I'd suggest you take it up with your
>> hardware vendor, and quite possibly just decide to not buy the
>> hardware. Vote with your feet. Join the OpenCores groups. Make your
>> own FPGA's.
>
>I'm concerned that in a few years time such systems will be rare and
>hard to come by (possibly even illegal). I find such system pissing
> all over the spirit of the GPL.

And I too see this scenario developing as the years go by, prodded to 
keep it in motion at every twitch of a muscle to do other wise by the 
likes of M$ because it cements the last brick into his domination of 
the world scene.  It scares me bad enough to keep my powder dry & in 
good supply if you get my drift.  DRM-less hardware will vanish from 
the supply chain unless smuggled in from au or nz.  And I do mean 
smuggled, with severe penalties for being caught at it.

> To me, the GPL has always been about 
> the freedom of modifying (in place, not making a clone).
>
>It's a fine line before we are in the territory of restricting what
>software can be used for. But for me this is not about restricting
> their rights as much as it is preventing them from restricting mine.
>
Right on.

>> And it's important to realize that signed kernels that you can't run
>> in modified form under certain circumstances is not at all a bad
>> idea in many cases.
>>
>> For example, distributions signing the kernel modules (that are
>> distributed under the GPL) that _they_ have compiled, and having
>> their kernels either refuse to load them entirely (under a "secure
>> policy") or marking the resulting kernel as "Tainted" (under a "less
>> secure" policy) is a GOOD THING.
>
>I dislike the former but the latter is acceptable (and, as you say, in
>some cases desirable). There is a big difference between refusing to
> run and printing/logging warnings.
>
>> Notice how the current GPLv3 draft pretty clearly says that Red Hat
>> would have to distribute their private keys so that anybody sign
>> their own versions of the modules they recompile, in order to
>> re-create their own versions of the signed binaries that Red Hat
>> creates. That's INSANE.

Where are the guys in the white jackets when we need them?

>> Btw, what about signed RPM archives? How well do you think a secure
>> auto-updater would work if it cannot trust digital signatures?
>
>I'm arguing the principle here, not the wording of the current draft.
>Signatures that are required for execution should be covered, those
> that result in warnings should not be. Imagine the shit storm if Red
> Hat decided to ship an rpm that didn't allow packages that weren't
> signed by them.
>
>It's basically about control. I do not find it reasonable to allow the
>vendor control of what goes or not on systems I've bought. They're
> free to put systems in place so they can detect that I've fiddled
> with it so they can deny me support. But if they want to make a
> completely closed system then they'll have to develop it on their own
> and not use my code. "Look but don't touch" is not sufficient for me.

Amen.  And on that point, we need a better method to detect that they 
have 'borrowed' FOSS code, and an expensive lawsuit settled in FOSS 
favor to set an enforcement example, but I have no imagination of a 
method they couldn't just as easily remove IF they had a coder worthy 
of the name of coder who wanted to be so larsonous.

>Rgds
>Pierre
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe
> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
Cheers, Gene
People having trouble with vz bouncing email to me should add the word
'online' between the 'verizon', and the dot which bypasses vz's
stupid bounce rules.  I do use spamassassin too. :-)
Yahoo.com and AOL/TW attorneys please note, additions to the above
message by Gene Heskett are:
Copyright 2006 by Maurice Eugene Heskett, all rights reserved.
