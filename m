Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUJEAeb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUJEAeb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 20:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268720AbUJEAd7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 20:33:59 -0400
Received: from smtp-roam.Stanford.EDU ([171.64.10.152]:8685 "EHLO
	smtp-roam.Stanford.EDU") by vger.kernel.org with ESMTP
	id S268722AbUJEAdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 20:33:47 -0400
Message-ID: <4161EC43.3070907@myrealbox.com>
Date: Mon, 04 Oct 2004 17:35:15 -0700
From: Andy Lutomirski <luto@myrealbox.com>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Linus Torvalds <torvalds@osdl.org>,
       Florian Bohrer <Florian.Bohrer@t-online.de>,
       linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [PATCH] AES x86-64-asm impl.
References: <2KWl4-wq-25@gated-at.bofh.it> <m3acv4zz5f.fsf@averell.firstfloor.org> <41613937.8BF0FE0D@users.sourceforge.net> <20041004130839.GA9075@muc.de>
In-Reply-To: <20041004130839.GA9075@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Mon, Oct 04, 2004 at 02:51:19PM +0300, Jari Ruusu wrote:

>>
>>Here we go again...
>>
>>Linus promised that he will not merge my code, and I am quite happy with my
>>code not being anywhere near mainline linux cryptoapi.
>>
>>Linus, please consider dropping this.
> 
> 
> Ok, I will drop that version and go back to the older version based
> on the i386 code.
> 
> -Andi

WHAT?  We're dropping potentially better code because someone _who 
didn't submit it_ disagrees for personal political reasons?  (Jari- I'm 
not questioning your reasons for not wanting to be involved in 
cryptoapi, but IIRC you did release that code under the GPL.)

--Andy
