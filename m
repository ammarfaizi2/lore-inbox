Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317641AbSIEPIY>; Thu, 5 Sep 2002 11:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317642AbSIEPHc>; Thu, 5 Sep 2002 11:07:32 -0400
Received: from grace.speakeasy.org ([216.254.0.2]:4627 "HELO
	grace.speakeasy.org") by vger.kernel.org with SMTP
	id <S317641AbSIEPH3>; Thu, 5 Sep 2002 11:07:29 -0400
Date: Thu, 5 Sep 2002 10:12:05 -0500 (CDT)
From: Mike Isely <isely@pobox.com>
X-X-Sender: isely@grace.speakeasy.net
Reply-To: Mike Isely <isely@pobox.com>
To: Tomas Szepe <szepe@pinerecords.com>
cc: Horst von Brand <vonbrand@inf.utfsm.cl>,
       "Henning P. Schmiedehausen" <hps@intermeta.de>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.20-pre5-ac2: Promise Controller LBA48 DMA fixed
In-Reply-To: <20020905145610.GW24323@louise.pinerecords.com>
Message-ID: <Pine.LNX.4.44.0209051008060.10556-100000@grace.speakeasy.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2002, Tomas Szepe wrote:

> > But in the future, if I post more fixes to the IDE driver (probably 
> > won't), I'll sanitize as I go along.
> 
> From what Andre said in the past I've gathered he's very much ok with
> code sanitizing and cleanups... Knock yourself out if you please.
> 
> > I find it amusing that a post from me which describes evidence of
> > completely broken Promise controller DMA goes unresponded to, yet there
> > are concerns about whether to spell code as "a != b" or "!(a == b)".
> 
> Well, your patch is obviously correct -- there's not much to comment on.
> 

I was refering to the longer unanswered messages posted over the weekend
(search for subject "trashed") asking for guidance on how to proceed.  
Having never debugged IDE before, I was hoping for some help.

  -Mike

                        |         Mike Isely          |     PGP fingerprint
    POSITIVELY NO       |                             | 03 54 43 4D 75 E5 CC 92
 UNSOLICITED JUNK MAIL! |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |   (spam-foiling  address)   |

