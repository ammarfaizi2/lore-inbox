Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290823AbSBRR6K>; Mon, 18 Feb 2002 12:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290882AbSBRRyG>; Mon, 18 Feb 2002 12:54:06 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:59471 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S290815AbSBRRkg>; Mon, 18 Feb 2002 12:40:36 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: dalecki@evision-ventures.com (Martin Dalecki),
        jgarzik@mandrakesoft.com (Jeff Garzik),
        torvalds@transmeta.com (Linus Torvalds), linux-kernel@vger.kernel.org
Subject: Re: PATCH 2.5.4 i810_audio, bttv, working at all.
In-Reply-To: <E16azBG-0005DM-00@the-village.bc.nu>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 18 Feb 2002 10:36:01 -0700
In-Reply-To: <E16azBG-0005DM-00@the-village.bc.nu>
Message-ID: <m1r8ni4rr2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > But please just show me a non x86 architecture which is using the 
> > i810_audio driver! 
> 
> To start with the i810 audio code is the same code as is used for the AMD768
> southbridge which can be used with an Alpha processor + AMD762

Or equally fun I won't be surprised if the i870 chipset for the next
generation ia64 itanium processor (mckinley) could use this code.

Eric
