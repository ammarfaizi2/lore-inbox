Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVFBBSt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVFBBSt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261532AbVFBBRY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:17:24 -0400
Received: from mail.tmr.com ([64.65.253.246]:23174 "EHLO gaimboi.tmr.com")
	by vger.kernel.org with ESMTP id S261546AbVFBBPj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:15:39 -0400
Message-ID: <429E5D8B.7090402@tmr.com>
Date: Wed, 01 Jun 2005 21:14:51 -0400
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Crilly <jim@why.dont.jablowme.net>
CC: toon@hout.vanvergehaald.nl, mrmacman_g4@mac.com, ltd@cisco.com,
       linux-kernel@vger.kernel.org, kraxel@suse.de, dtor_core@ameritech.net,
       7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
References: <20050530093420.GB15347@hout.vanvergehaald.nl> <429B0683.nail5764GYTVC@burner> <46BE0C64-1246-4259-914B-379071712F01@mac.com> <429C4483.nail5X0215WJQ@burner> <87acmbxrfu.fsf@bytesex.org> <429DD036.nail7BF7MRZT6@burner> <20050601154245.GA14299@voodoo> <429DE874.nail7BFM1RBO2@burner> <20050601172900.GC14299@voodoo> <429DF581.nail7BFUL8PFN@burner> <20050601175920.GD14299@voodoo>
In-Reply-To: <20050601175920.GD14299@voodoo>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Crilly wrote:
> On 06/01/05 07:50:57PM +0200, Joerg Schilling wrote:
> 
>>"Jim Crilly" <jim@why.dont.jablowme.net> wrote:
>>
>>
>>>I don't use cdda2wav so I can't comment, but every other ripping tool that
>>>I've used on Linux has had no problem using the /dev/whatever interface, so
>>>once again it appears that your tool is the blacksheep for no good reason.
>>
>>You should use it as it is even used by people on Win32 because it is the
>>best DAE program for even badly readable sources.
> 
> 
> I'm not an audiophile, I can't tell the difference between a mp3 encoded at
> 128k and one encoded at 160k so I really doubt I could tell the difference
> between what cdda2wav and what most other DAE programs would produce. So
> given that the quality of the rips will be effectively equal to my ears,
> I'll use whatever's most convenient.

The "quality" or fidelity isn't the issue here, but rather the rip being 
deterministic and producing the same (as as often as possible, correct) 
data. Joerg used the "paranoia" library to do the ripping validation, 
and I'm unconvinced that there is anything better in that regard.

The device names are totally another issue, which I'm not ready to drag 
around the block yet again.

-- 
bill davidsen <davidsen@tmr.com>
   CTO TMR Associates, Inc
   Doing interesting things with small computers since 1979
