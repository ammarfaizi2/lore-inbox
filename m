Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287858AbSBMRCL>; Wed, 13 Feb 2002 12:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287862AbSBMRCA>; Wed, 13 Feb 2002 12:02:00 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47628 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287764AbSBMRBu>;
	Wed, 13 Feb 2002 12:01:50 -0500
Message-ID: <3C6A9BFA.739020F9@mandrakesoft.com>
Date: Wed, 13 Feb 2002 12:01:46 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: torvalds@transmeta.com, dalecki@evision-ventures.com,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <3C6A5D79.33C31910@mandrakesoft.com>
		<Pine.LNX.4.33.0202131028130.13632-100000@home.transmeta.com> <20020213.084952.68037450.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



In the specific case mentioned in $subject, i810_audio has already been
fixed by Pete Zaitcev "the right way", and IIRC Gerd or somebody posted
a better patch for bttv, too.  So $subject is actually taken care of...


"David S. Miller" wrote:
> And if nobody else ends up doing it, you are right it will be people
> like Jeff and myself doing it.

and have been doing it in the past :)


> So what we are asking is to allow a few weeks for that and not crap up
> the tree meanwhile.  This is so that the cases that need to be
> converted are harder to find.

Yes, please..


> Actually, you're only half right in one regard.  Most people I've
> pointed to Documentation/DMA-mapping.txt have responded "Oh, never saw
> that before, that looks easy to do.  Thanks I'll fix it up properly
> for you."

I still get plenty of the "but virt_to_phys works fine for me" crowd too
:)

	Jeff



-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
