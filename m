Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261521AbTCZJMH>; Wed, 26 Mar 2003 04:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbTCZJMH>; Wed, 26 Mar 2003 04:12:07 -0500
Received: from p508205DB.dip0.t-ipconnect.de ([80.130.5.219]:16619 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S261521AbTCZJMF>;
	Wed, 26 Mar 2003 04:12:05 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Arne Koewing <ark@gmx.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Synaptics touchpad with Trackpoint needs ps/2 reset
From: Arne Koewing <ark@gmx.net>
Date: Wed, 26 Mar 2003 10:22:47 +0100
In-Reply-To: <20030326095010.A17442@ucw.cz> (Vojtech Pavlik's message of
 "Wed, 26 Mar 2003 09:50:10 +0100")
Message-ID: <87r88uiis8.fsf@gmx.net>
User-Agent: Gnus/5.090016 (Oort Gnus v0.16) Emacs/21.2 (gnu/linux)
References: <87r88uv7hf.fsf@localhost.i-did-not-set--mail-host-address--so-tickle-me>
	<20030326095010.A17442@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Tue, Mar 25, 2003 at 08:25:47AM +0100, Arne Koewing wrote:
>> Hi!
>> 
>> I recently posted this to linux-kernel (with a different subject)
>> I had included a wrong ptch there, i think this one is ok.
>
> Do we really need RESET_BAT? Doesn't any other command help?
>
I've used this because it is what tpconfig is using.
I've tried all I could think of 
(except of Synaptics-specials that I might not know)
RESET_BAT is the only one that works...

I'll study the Synaptics TP Interfacing Guide again...

Arne

