Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751041AbWI2KSe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751041AbWI2KSe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 06:18:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751067AbWI2KSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 06:18:34 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:20617 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750887AbWI2KSd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 06:18:33 -0400
Message-ID: <451CF22D.4030405@aitel.hist.no>
Date: Fri, 29 Sep 2006 12:15:09 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
MIME-Version: 1.0
To: tglx@linutronix.de
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@suse.de>,
       Michiel de Boer <x@rebelhomicide.demon.nl>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: GPLv3 Position Statement
References: <1158941750.3445.31.camel@mulgrave.il.steeleye.com>	 <451798FA.8000004@rebelhomicide.demon.nl>	 <17687.46268.156413.352299@cse.unsw.edu.au>	 <1159183895.11049.56.camel@localhost.localdomain> <1159200620.9326.447.camel@localhost.localdomain>
In-Reply-To: <1159200620.9326.447.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner wrote:
> On Mon, 2006-09-25 at 12:31 +0100, Alan Cox wrote:
>   
>> The GPLv3 rewords it in an attempt to be clearer but also I think rather
>> more over-reaching. It's not clear what for example happens with a
>> rented device containing GPL software but with DRM on the hardware.
>> Thats quite different to owned hardware. GPLv2 leaves it open for the
>> courts to make a sensible decision per case, GPLv3 tries to define it in
>> advance and its very very hard to define correctly.
>>     
>
> Also the prevention of running modified versions is not only caused by
> economic interests and business models. There are also scenarios where
> it is simply necessary:
>
> - The liability for damages, where the manufacturer of a device might
> be responsible in case of damage when he abandoned the prevention. This
> applies to medical devices as well as to lasers, machine tools and many
> more. Device manufacturers can not necessarily escape such liabilities
> as it might be considered grossly negligent to hand out the prevention
> key, even if the user signed an exemption from liability.
>   
This seems silly to me.  Sure, lasers and medical equipment is
dangerous if used wrong.  When such equipment is
controlled by software, then changing that software brings
huge responsibility.  But it shouldn't be made impossible.

They can provide the key, with the warning that _using_ it
means you are on your own and take all responsibility.

I can take the covers off a cd player and let the laser
shine into the room.  Nothing prevents me from doing
that, it isn't welded shut or anything.  And it might
be useful if I ever need a laser beam.  Of course I am
then responsible if I take someone's eye out.  CD players
have warning labels about this.  And the same can be done
for the keys to dangerous software.
> - Regulations to prevent unauthorized access to radio frequencies, which
> is what concerns e.g. cellphone manufacturers.
>   
Unauthorized use is illegal and easy enough to track down.
No special protection is needed.  And it cannot be enforced
by making the phones har to modify - any radio amateur knows
how to build from scratch a transmitter to jam the GSM bands
if he should be inclined to do so. Anyone can look this up in
books too.

Helge Hafting
