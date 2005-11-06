Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVKFXrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVKFXrM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVKFXrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:47:11 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:13319 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932375AbVKFXrK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:47:10 -0500
To: Mark Knecht <markknecht@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 3D video card recommendations
References: <1131112605.14381.34.camel@localhost.localdomain>
	<5bdc1c8b0511040710q4a4ce3eend6edc2b4027e33b0@mail.gmail.com>
From: Nix <nix@esperi.org.uk>
X-Emacs: because editing your files should be a traumatic experience.
Date: Sun, 06 Nov 2005 23:46:39 +0000
In-Reply-To: <5bdc1c8b0511040710q4a4ce3eend6edc2b4027e33b0@mail.gmail.com> (Mark
 Knecht's message of "4 Nov 2005 15:11:13 -0000")
Message-ID: <87ek5t9w68.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Nov 2005, Mark Knecht announced authoritatively:
> On 11/4/05, Steven Rostedt <rostedt@goodmis.org> wrote:
>> I'm currently putting together (ordering parts for) another machine. It
>> will be a AMD64 X2. Now I'm looking into a video card for this.  Up till
>> now, I've always used NVidia.  But I also want to test 3D acceleration
>> under Ingo's -rt patch.  So now I need something that does not have a
>> priority module.
>>
>> I'm not much of a gamer, although I do play every so often. So I don't
>> need the highest quality card, but I also want something that is still
>> pretty good. For example, I currently have a NVidia GeForce 6800 GT
>> card.  So I'm hoping to get something equivalent.
>>
>> I'm looking at the ATI Radeons.
>>
>> Any recommendations? (links to info would also be nice ;-)
> 
> Not a recommendation. Just a point to be aware of. The ATI Radeons, to
> get the best acceleration, seem to require that you use the ATI closed
> source drivers. Currently I haven't found an ATI closed source driver
> that supports 2.6.14. so I'm forced to use the Xorg radeon driver. I
> have no idea if this is very good. I don't think so as my glxgear
> numbers are pretty low. Much lower than the ATI driver running on
> 2.6.13-X.

Surely it depends on the Radeon. I get perfectly respectable numbers on
my Radeon 9250 (purchased because Dave Airlie said it was well-supported
by X.org :) ). It's not exactly Doom-playing quality, but it's good
enough for everything I'm doing with it, and it only cost thirty quid:
for that price you can afford to try it and see :)

(Later Radeons' 3D aren't fully supported yet in free drivers, as far as
I know.)

-- 
`Heinlein is quite competent at putting together sentences, but usually
he also puts together a plot to go with them.' --- Russ Allbery
