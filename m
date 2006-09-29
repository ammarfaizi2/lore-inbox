Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161586AbWI2TnU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161586AbWI2TnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWI2TnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:43:20 -0400
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:48293 "EHLO
	elasmtp-banded.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1422661AbWI2TnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:43:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=D8JduP+IN1Y2CKvlH3A8ArzdesG7GVgyGTeVMExFbporM9NLec7qNPA4QFAmYj9I;
  h=Received:Message-ID:From:To:References:Subject:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Priority:X-MSMail-Priority:X-Mailer:X-MIMEOLE:X-ELNK-Trace:X-Originating-IP;
Message-ID: <03ff01c6e3ff$7d24b0c0$0225a8c0@Wednesday>
From: "jdow" <jdow@earthlink.net>
To: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>	 <451798FA.8000004@rebelhomicide.demon.nl>	 <17687.46268.156413.352299@cse.unsw.edu.au>	 <1159183895.11049.56.camel@localhost.localdomain> <1159200620.9326.447.camel@localhost.localdomain> <451CF22D.4030405@aitel.hist.no>
Subject: Re: GPLv3 Position Statement
Date: Fri, 29 Sep 2006 12:43:02 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="utf-8";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
X-ELNK-Trace: bb89ecdb26a8f9f24d2b10475b57112040041c05260cc61e97814775684e741c315182ab6dc9f291350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 71.116.187.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Helge Hafting" <helge.hafting@aitel.hist.no>
> Thomas Gleixner wrote:
>> On Mon, 2006-09-25 at 12:31 +0100, Alan Cox wrote:
>>   
>>> The GPLv3 rewords it in an attempt to be clearer but also I think rather
>>> more over-reaching. It's not clear what for example happens with a
>>> rented device containing GPL software but with DRM on the hardware.
>>> Thats quite different to owned hardware. GPLv2 leaves it open for the
>>> courts to make a sensible decision per case, GPLv3 tries to define it in
>>> advance and its very very hard to define correctly.
>>>     
>>
>> Also the prevention of running modified versions is not only caused by
>> economic interests and business models. There are also scenarios where
>> it is simply necessary:
>>
>> - The liability for damages, where the manufacturer of a device might
>> be responsible in case of damage when he abandoned the prevention. This
>> applies to medical devices as well as to lasers, machine tools and many
>> more. Device manufacturers can not necessarily escape such liabilities
>> as it might be considered grossly negligent to hand out the prevention
>> key, even if the user signed an exemption from liability.
>>   
> This seems silly to me.  Sure, lasers and medical equipment is
> dangerous if used wrong.  When such equipment is
> controlled by software, then changing that software brings
> huge responsibility.  But it shouldn't be made impossible.
> 
> They can provide the key, with the warning that _using_ it
> means you are on your own and take all responsibility.

In some more rational parts of the world (presuming they exist
evidence to the contrary) this approach might work. This requires
a people and government that are rather libertarian with the people
taking full responsibility for their own actions. Now, I live in
the country that awarded a woman millions of dollars because she
was stupid enough to put a hot container of coffee in her lap as
she reached over to her purse to make change. Of course it spilled
and scorched her in a "nasty place to be scorched." This is also
the country that awarded two drunken idiots who decided to trim a
hedge with a rotary lawn mower. They tried to pick it up by the
skirts and lost their fingers to the spinning blades. They sued
the manufacturer for allowing them to be stupid - and won. So the
blunt answer is "Product Liability."

> I can take the covers off a cd player and let the laser
> shine into the room.  Nothing prevents me from doing
> that, it isn't welded shut or anything.  And it might
> be useful if I ever need a laser beam.  Of course I am
> then responsible if I take someone's eye out.  CD players
> have warning labels about this.  And the same can be done
> for the keys to dangerous software.

Those warnings probably are not enough in a US court of law. But
they are enough to discourage most idiots who do get blinded by
their own stupidity from trying to sue.

>> - Regulations to prevent unauthorized access to radio frequencies, which
>> is what concerns e.g. cellphone manufacturers.
>>   
> Unauthorized use is illegal and easy enough to track down.
> No special protection is needed.  And it cannot be enforced
> by making the phones har to modify - any radio amateur knows
> how to build from scratch a transmitter to jam the GSM bands
> if he should be inclined to do so. Anyone can look this up in
> books too.

The bozo has to go through enough effort to build such a jammer
that it'd (mostly) insulate the parts manufactures from liability.
It's a little more work than pulling some CDROM screws and blinding
people in the room as a result. (Yeah, I darned well know how little
actual work is involved. But actual knowledge is also involved so it
would be hard for that jammer to escape personal responsibility. Of
course, there is the spark gap jammer.... Anecdotal evidence shows
that the spark gap noise can motivate the Los Angeles FCC office to
get off their lazy asses in a hurry, though.)

{^_-}   Joanne
