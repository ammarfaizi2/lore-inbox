Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261266AbVCCUZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261266AbVCCUZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262449AbVCCUW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 15:22:58 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2983 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261266AbVCCUTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 15:19:51 -0500
Message-ID: <4227714E.5070001@pobox.com>
Date: Thu, 03 Mar 2005 15:19:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: torvalds@osdl.org, tglx@linutronix.de, bunk@stusta.de, greg@kroah.com,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	<42268749.4010504@pobox.com>	<20050302200214.3e4f0015.davem@davemloft.net>	<42268F93.6060504@pobox.com>	<4226969E.5020101@pobox.com>	<20050302205826.523b9144.davem@davemloft.net>	<4226C235.1070609@pobox.com>	<20050303080459.GA29235@kroah.com>	<4226CA7E.4090905@pobox.com>	<Pine.LNX.4.58.0503030750420.25732@ppc970.osdl.org>	<20050303170808.GG4608@stusta.de>	<1109877336.4032.47.camel@tglx.tec.linutronix.de>	<Pine.LNX.4.58.0503031135190.25732@ppc970.osdl.org>	<42276AF5.3080603@pobox.com> <20050303120408.746f49a8.davem@davemloft.net>
In-Reply-To: <20050303120408.746f49a8.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Thu, 03 Mar 2005 14:52:21 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>I disagree it's unsolvable:
>>
>>1) At some point in the -rc cycle, you put your foot down and say 
>>"nothing but bugfixes."
> 
> 
> Linus actually did, as Andrew showed you, and it was actually followed
> quite well.
> 
> You keep ignoring this evidence, why?
> 
> You can quiet me up about this by showing counter evidence to what
> Andrew pointed out to you.

I agree this occurred.  I'm not ignoring the evidence, you are ignoring 
the part you didn't quote -- the key component of the "users don't test" 
problem.

A user who doesn't follow LKML does not know that Linus put his foot 
down in 2.6.11-rc3.  or 2.6.10-rc2.  or 2.6.9-rc1.  A user just sees "at 
some random point, which is never consistent, it becomes bugfixes only."

The lack of consistency is the problem.  That is why posters in this 
thread keep suggesting a -pre/-rc split.  That is why posters in this 
thread talk about "users don't trust -rc to mean -rc."

Marcelo consistently says "-rc means serious bugfixes only" and never 
deviates from that.  And that builds users TRUST.


"putting down your foot" is only half the solution.

The other half is, "users need not follow LKML to know when this occurs."

	Jeff


