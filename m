Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261458AbREOUci>; Tue, 15 May 2001 16:32:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261459AbREOUc3>; Tue, 15 May 2001 16:32:29 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:29700 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261458AbREOUcL>;
	Tue, 15 May 2001 16:32:11 -0400
To: esr@thyrsus.com
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 15 May 2001 22:32:00 +0200
In-Reply-To: "Eric S. Raymond"'s message of "Sun, 13 May 2001 11:25:44 -0400"
Message-ID: <d3d79awdz3.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Eric" == Eric S Raymond <esr@thyrsus.com> writes:

Eric> Jes Sorensen <jes@sunsite.dk>:
Eric> # These were separate questions in CML1 derive MAC_SCC from MAC
Eric> & SERIAL derive MAC_SCSI from MAC & SCSI derive SUN3_SCSI from
Eric> (SUN3 | SUN3X) & SCSI
>>  As Alan already pointed out thats assumption is invalid.

Eric> I'm in touch with Ray Knight directly and will fix this as he
Eric> requests.

If Ray wants to fix things, it's just fine with me.
 
>> Yes I have objections. I thought I had made this clear a long time
>> ago: Go play with another port and leave the m68k port alone.

Eric> Does this mean you'll take over maintaining the CML2 rules files
Eric> for the m68k port, so I don't have to?  That would be wonderful.

For a start, so far there has been no reason whatsoever to change the
format of definitions.

Eric> Reasoned objections can change my behavior.  Grunting
Eric> territorial challenges at me will not.  You have two options:
Eric> (1) persuade Linus that the whole CML2 thing is a bad idea and
Eric> should be dropped, or (2) work with me to correct any errors I
Eric> have made and improve the system.  Growling at me and hoping I
Eric> go away won't work, not when I've invested a year's effort in
Eric> this project.

So far you have only been irritating developers for no reason. What I
asked you to do is to NOT change whatever config options developers
developers felt were necessary to introduce. If you want to change the
format of the config.in files go ahead. Messing around with the config
options themselves is *not* for you to do, nor are you to impose a
more restrictive space for people to work in.

Jes
