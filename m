Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132599AbRDKO7U>; Wed, 11 Apr 2001 10:59:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132598AbRDKO7K>; Wed, 11 Apr 2001 10:59:10 -0400
Received: from m292-mp1-cvx1a.col.ntl.com ([213.104.69.36]:35712 "EHLO
	[213.104.69.36]") by vger.kernel.org with ESMTP id <S132596AbRDKO7F>;
	Wed, 11 Apr 2001 10:59:05 -0400
To: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE817@orsmsx35.jf.intel.com>
	<20010411012354.E4214@grulic.org.ar>
From: John Fremlin <chief@bandits.org>
Date: 11 Apr 2001 15:59:00 +0100
In-Reply-To: John R Lenton's message of "Wed, 11 Apr 2001 01:23:54 -0300"
Message-ID: <m2g0ffh497.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 John R Lenton <john@grulic.org.ar> writes:

[...]

> Just today a friend saw my box shutdown via the powerbutton and
> wondered if he coudln't set his up to trigger a different event
> (actually two: he wanted his sister - the guilty party - zapped, and
> a webcam shot of her face to prove it)...

That is in fact possible (given that you have the zapper) on certain
hardware with my pmpolicy patch

        http://john.snoop.dk/programs/linux/offbutton

It uses APM instead of ACPI because ACPI doesn't work on my
computer. I have an updated version of the patch for 2.4.2, but I
haven't got round to uploading it.

-- 

	http://www.penguinpowered.com/~vii
