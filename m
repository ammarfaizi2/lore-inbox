Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290293AbSBORdX>; Fri, 15 Feb 2002 12:33:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290306AbSBORbs>; Fri, 15 Feb 2002 12:31:48 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27141 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S290293AbSBORbS>;
	Fri, 15 Feb 2002 12:31:18 -0500
Message-ID: <3C6D45E3.59A7D72D@mandrakesoft.com>
Date: Fri, 15 Feb 2002 12:31:15 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17-2mdksmp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Linux-Kernel list <linux-kernel@vger.kernel.org>, dirk.hohndel@intel.com
Subject: Re: Disgusted with kbuild developers
In-Reply-To: <3C6D3D9A.565EC59D@mandrakesoft.com> <20020215115147.A7528@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Jeff Garzik <jgarzik@mandrakesoft.com>:
> > I would find this pathetic, if it didn't make me so mad.
> > Making an end run around the system, are we, Eric?
> 
> No.  I'm doing what Dirk Hohndel recommended I do during a phone call
> that happened at his initiative, last Friday morning.
> 
> What "system" would you be referring to, anyway, Jeff?  Is there some
> reason a respected open-source developer like Dirk who has concerns
> should not have a conversation with Linus to address problems he thinks
> are significant?  Is there some reason I should not have asked the kbuild
> team members to give him appropriate background?
> 
> I don't understand what is upsetting you.  Is there some rule that all
> conversations with Linus must go through Jeff Garzik?  If so, I was never
> informed of it.

Eric,

What I see on linux-kernel is you writing long diatribes, and then
promptly ignoring feedback from kernel developers who would actually be
using your system.  After months and months of being told that
Configure.help needed to be split up, you just continued to whine. 
Linus finally sat down and did it himself.  Back in December, Linus
talked about per-driver and/or per-subsystem metadata files, which would
contain (among other things) the config information.  That seems like a
sane option to me, and other developers agreed.  You ignored that too.

With regards to kbuild (not CML2), Keith publicly stated he didn't care
about 2.5.

I feel sorry about that you have troubled Dirk, without giving him all
the facts.

	Jeff


-- 
Jeff Garzik      | "I went through my candy like hot oatmeal
Building 1024    |  through an internally-buttered weasel."
MandrakeSoft     |             - goats.com
