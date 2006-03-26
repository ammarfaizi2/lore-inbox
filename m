Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWCZNYi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWCZNYi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 08:24:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWCZNYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 08:24:38 -0500
Received: from main.gmane.org ([80.91.229.2]:22700 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750732AbWCZNYi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 08:24:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 15:22:05 +0200
Message-ID: <1dlbuut0mmyo3$.13773nowi9lw5.dlg@40tude.net>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <1143376008.3064.0.camel@laptopd505.fenrus.org> <F31089B5-0915-439D-B218-009384E2148F@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-84-221-14-16.cust-adsl.tiscali.it
User-Agent: 40tude_Dialog/2.0.15.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Mar 2006 07:34:12 -0500, Kyle Moffett wrote:

> On Mar 26, 2006, at 07:26:48, Arjan van de Ven wrote:
>> On Sun, 2006-03-26 at 06:52 -0500, Kyle Moffett wrote:
>>> On Fri, 24 Mar 2006 17:46:27 -0500 Kyle Moffett  
>>> <mrmacman_g4@mac.com> wrote:
>>>> I'm working on some sample patches now which I'll try to post in  
>>>> a few days if I get the time.
>>>
>>> Ok, here's a sample of the KABI conversion and cleanup patches  
>>> that I'm proposing.  I have a few fundamental goals for these  
>>> patches:
>>
>> is KABI the right name? I mean.. from the kernel pov it's the  
>> interface to userspace ;)
> 
> Well I guess you could call it UABI, but that might also imply that  
> it's _userspace_ that defines the interface, instead of the kernel.   
> Since the headers themselves are rather tightly coupled with the  
> kernel, I think I'll stick with the KABI name for now (unless  
> somebody can come up with a better one, of course :-D).

Well, since I guess UAKDABI (User Accessible Kernel Defined) is out of
the question, what about LABI? (Linux ABI)

-- 
Giuseppe "Oblomov" Bilotta

Axiom I of the Giuseppe Bilotta
theory of IT:
Anything is better than MS

