Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751330AbWCZMeg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbWCZMeg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 07:34:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751336AbWCZMeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 07:34:36 -0500
Received: from smtpout.mac.com ([17.250.248.88]:40128 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751332AbWCZMef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 07:34:35 -0500
In-Reply-To: <1143376008.3064.0.camel@laptopd505.fenrus.org>
References: <200603141619.36609.mmazur@kernel.pl> <200603231811.26546.mmazur@kernel.pl> <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com> <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <20060326065205.d691539c.mrmacman_g4@mac.com> <1143376008.3064.0.camel@laptopd505.fenrus.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F31089B5-0915-439D-B218-009384E2148F@mac.com>
Cc: nix@esperi.org.uk, rob@landley.net, mmazur@kernel.pl,
       linux-kernel@vger.kernel.org, llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 0/2] KABI example conversion and cleanup
Date: Sun, 26 Mar 2006 07:34:12 -0500
To: Arjan van de Ven <arjan@infradead.org>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2006, at 07:26:48, Arjan van de Ven wrote:
> On Sun, 2006-03-26 at 06:52 -0500, Kyle Moffett wrote:
>> On Fri, 24 Mar 2006 17:46:27 -0500 Kyle Moffett  
>> <mrmacman_g4@mac.com> wrote:
>>> I'm working on some sample patches now which I'll try to post in  
>>> a few days if I get the time.
>>
>> Ok, here's a sample of the KABI conversion and cleanup patches  
>> that I'm proposing.  I have a few fundamental goals for these  
>> patches:
>
> is KABI the right name? I mean.. from the kernel pov it's the  
> interface to userspace ;)

Well I guess you could call it UABI, but that might also imply that  
it's _userspace_ that defines the interface, instead of the kernel.   
Since the headers themselves are rather tightly coupled with the  
kernel, I think I'll stick with the KABI name for now (unless  
somebody can come up with a better one, of course :-D).

Cheers,
Kyle Moffett

