Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319126AbSHMSlJ>; Tue, 13 Aug 2002 14:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319127AbSHMSlI>; Tue, 13 Aug 2002 14:41:08 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1552 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S319126AbSHMSkF>; Tue, 13 Aug 2002 14:40:05 -0400
Date: Tue, 13 Aug 2002 11:32:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Rob Landley <landley@trommello.org>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Daniel Phillips <phillips@arcor.de>, Larry McVoy <lm@bitmover.com>,
       <frankeh@watson.ibm.com>, <davidm@hpl.hp.com>,
       David Mosberger <davidm@napali.hpl.hp.com>,
       "David S. Miller" <davem@redhat.com>, <gh@us.ibm.com>,
       <Martin.Bligh@us.ibm.com>, William Lee Irwin III <wli@holomorphy.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <200208131818.g7DIIgf321912@pimout5-ext.prodigy.net>
Message-ID: <Pine.LNX.4.44.0208131125240.7411-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 13 Aug 2002, Rob Landley wrote:
> 
> > Having a license that explicitly states that people who
> > contribute and use Linux shouldn't sue you over it might
> > prevent some problems.
> 
> Such a clause is what IBM insisted on having in ITS open source license.  You 
> sue, your rights under this license terminate, which is basically automatic 
> grounds for a countersuit for infringement.

Note that I personally think the "you screw with me, I screw with you"  
approach is a fine one. After all, the GPL is based on "you help me, I'll
help you", so it fits fine.

However, it doesn't work due to the distributed nature of the GPL. The FSF
tried to do something like it in the GPL 3.0 discussions, and the end
result was a total disaster. The GPL 3.0 suggestion was something along
the lines of "you sue any GPL project, you lose all GPL rights". Which to 
me makes no sense at all - I could imagine that there might be some GPL 
project out there that _deserves_ getting sued(*) and it has nothing to do 
with Linux.

		Linus

(*) "GNU Emacs, the defendent, did inefariously conspire to play 
towers-of-hanoy, while under the guise of a harmless editor".

