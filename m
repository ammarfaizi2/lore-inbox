Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262606AbUEAX2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262606AbUEAX2P (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 May 2004 19:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbUEAX2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 May 2004 19:28:15 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:56767 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S262648AbUEAX2F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 May 2004 19:28:05 -0400
In-Reply-To: <Pine.LNX.4.58.0405011541330.18014@ppc970.osdl.org>
References: <772768DC-9BA3-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.44.0405011529541.30657-100000@xanadu.home> <20040501205336.GA27607@valve.mbsi.ca> <20040501173450.006bae55.seanlkml@rogers.com> <3F6634E3-9BB9-11D8-B83D-000A95BCAC26@linuxant.com> <Pine.LNX.4.58.0405011541330.18014@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3114F1F7-9BC7-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: rusty@rustcorp.com.au, tconnors+linuxkernel1083378452@astro.swin.edu.au,
       linux-kernel@vger.kernel.org, riel@redhat.com, mbligh@aracnet.com,
       Sean Estabrooks <seanlkml@rogers.com>, nico@cam.org
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] clarify message and give support contact for non-GPL modules
Date: Sat, 1 May 2004 19:28:03 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

As  previously mentioned, I have offered many patches and a lot of 
source to the community throughout the last 15 years. Either personally 
or via Linuxant, under various licenses (including the GPL) depending 
on the constraints imposed by each situation, and continue doing so. In 
the workaround case, we should have admittedly sent a patch earlier 
instead of putting in the \0 and I sincerely apologized for that.

The modules in question are not binary-only, but mixed source/binary. 
With the submitted patch, we are also offering to take as much support 
burden off the community by clarifying the messages to explicitly 
direct users to where they should go for help when using third-party 
modules.

With all due respect, your claims that we are offering nothing / not 
giving back are not factual and you should not take position based on 
either incorrect information or a very narrow / alarmist interpretation 
of what we are doing.

Regards
Marc

On May 1, 2004, at 6:48 PM, Linus Torvalds wrote:
>
> On Sat, 1 May 2004, Marc Boucher wrote:
>>
>> I think that your wording is problematic, because:
>
> No.
>
> You seem to believe that you can get something for nothing.
>
> Wrong.
>
> You offer nothing to the open-source community, you get nothing back. 
> That
> means very much that people don't support what you're doing, and you
> should realize that as far as the rest of the kernel is concerned, you
> ARE tainting it.
>
> The GPL is about a symbiotic relationship, where people help each 
> other.
> In contrast, a binary module is a parasite - giving nothing back to the
> community.
>
> So live with that fact. Don't try to make it look like anything else.
>
> 		Linus
>

