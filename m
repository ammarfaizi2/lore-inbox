Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264944AbSLGXgw>; Sat, 7 Dec 2002 18:36:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSLGXgu>; Sat, 7 Dec 2002 18:36:50 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:7186 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id <S264944AbSLGXgq>;
	Sat, 7 Dec 2002 18:36:46 -0500
Message-ID: <3DF287D8.3060004@namesys.com>
Date: Sun, 08 Dec 2002 02:44:24 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021016
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: Proposed ACPI Licensing change
References: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com> <20021207002405.GR2544@fs.tum.de> <astkea$6ej$1@penguin.transmeta.com>
In-Reply-To: <EDC461A30AC4D511ADE10002A5072CAD04C7A57F@orsmsx119.jf.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Linus.  I don't think that I have any inherent moral right to 
dual-license reiserfs, but it sure is pragmatic to do so, and the 
courtesy of permitting me to do so is gratefully accepted from our 
contributors.  

A bit more than half of our income comes from the dual licensing, and 
we'd not have survived to this date fiscally without it.  If anyone on 
the reiserfs team ever owns a Boxster;-) at sometime in the future, it 
will be from dual-licensing to Apple, a storage appliance vendor, or the 
like.

Hans

Linus Torvalds wrote:

>In article <20021207002405.GR2544@fs.tum.de>,
>Adrian Bunk  <bunk@fs.tum.de> wrote:
>  
>
>>You can't forbid people to send GPL-only patches, so if a person doesn't
>>want his patch under your looser license you can't enforce that he also
>>releases it under your looser license.
>>    
>>
>
>That's true, but on the other hand we've had these dual-license things
>before (PCMCIA has been mentioned, but we've had reiserfs and a number
>of drivers like aic7xxx too), and I don't think I've _ever_ gotten a
>patch submission that disallowed the dual license. 
>
>In fact, I don't think I'd even merge a patch where the submitter tried
>to limit dual-license code to a simgle license (it might happen with
>some non-maintained stuff where the original source of the dual license
>is gone, but if somebody tried to send me an ACPI patch that said "this
>is GPL only", then I just wouldn't take it). 
>
>I suspect the same "refuse to accept license limiting patches" would be
>true of most kernel maintainers.  At least to me a choice of license by
>the _original_ author is a hell of a lot more important than the
>technical legality of then limiting it to just one license. 
>
>So yes, dual-license code can become GPL-only, but not in _my_ tree. 
>
>Somebody else can go off and make their own GPL-only additions, and
>quite frankly I would find it so morally offensive to ignore the intent
>of the original author that I wouldn't take the code even if it was an
>improvement (and I've found that people who are narrow-minded about
>licenses are narrow-minded about other things too, so I doubt it _would_
>be an improvement). 
>
>		Linus
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>

