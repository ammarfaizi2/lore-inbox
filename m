Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129348AbQLPRLt>; Sat, 16 Dec 2000 12:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129408AbQLPRLk>; Sat, 16 Dec 2000 12:11:40 -0500
Received: from ferret.phonewave.net ([208.138.51.183]:34828 "EHLO
	tarot.mentasm.org") by vger.kernel.org with ESMTP
	id <S129348AbQLPRLZ>; Sat, 16 Dec 2000 12:11:25 -0500
Date: Sat, 16 Dec 2000 08:40:17 -0800 (PST)
From: ferret@phonewave.net
To: Keith Owens <kaos@ocs.com.au>
cc: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: Linus's include file strategy redux 
In-Reply-To: <13385.976949851@ocs3.ocs-net>
Message-ID: <Pine.LNX.3.96.1001216083753.22767A-100000@tarot.mentasm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 16 Dec 2000, Keith Owens wrote:

> On Fri, 15 Dec 2000 19:37:49 -0800 (PST), 
> ferret@phonewave.net wrote:
> >Do you have an alternative reccomendation? I've shown where the symlink
> >method WILL fail. You disagree that having the configured headers copied
> >is a workable idea. What else is there?
> 
> Use the pcmcia-cs method.  Ask where the kernel headers with a sensible
> default if the user just presses <ENTER>.

Well yes, but can you ask the user non-interactively and get a sensible
answer?


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
