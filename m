Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269276AbUJWAIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269276AbUJWAIs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269293AbUJWAGc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:06:32 -0400
Received: from c7ns3.center7.com ([216.250.142.14]:59587 "EHLO
	smtp.slc03.viawest.net") by vger.kernel.org with ESMTP
	id S269276AbUJWAEk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:04:40 -0400
Message-ID: <4179974D.3010105@drdos.com>
Date: Fri, 22 Oct 2004 17:27:09 -0600
From: "Jeff V. Merkey" <jmerkey@drdos.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Jeff V. Merkey" <jmerkey@drdos.com>
Cc: jonathan@jonmasters.org, brian wheeler <bdwheele@indiana.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux v2.6.9 and GPL Buyout
References: <1098480691.8033.8.camel@wombat.educ.indiana.edu>	 <41797B49.5020809@drdos.com> <35fb2e5904102216038257cb1@mail.gmail.com> <417990AE.5050806@drdos.com>
In-Reply-To: <417990AE.5050806@drdos.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff V. Merkey wrote:

> Jon Masters wrote:
>
>> I'd love for you to accept liability for this so we can pass all SCO
>> enquiries on to you.
>>
>> Jon.
>>
>
Jon and LKML,

Also, I will contact Allan Sullivan who represents IBM in the litigation 
and let them know I would be happy to
handle this an an advocate of the Linux Community. Alan Sullivan worked 
for me on the TRG/Novell lawsuit
and I know him. I will be more than happy to challenge any claims Linux 
folks think are bogus from SCO.

Since I am an expert in IP misappropriation (having wormed and squirmed 
my way through it for years) I think I could cut
through at lot of SCO's FUD (And you guys FUD as well). I could very 
easily get rid of most of thier claims provide
you guys will take out of the kernel:

XFS, JFS, NUMA for certain. You can maintain them as patches for the 
time being and let the vendors
who put them in deal with SCO on what belongs to whom.

I think their SMP claims are very weak at present. Novell has stated 
publically you can use their patents. I also
consent to Linux using any patents in my name for SMP in Linux IAW 
Novell's offer. Any IBM contributed
code should probably be removed and reimplemented by someone else, then 
SCO has no claims on it.

I have no idea what you should do about RCU. On this one, wait for the 
posting from SCO, then remove the code
and reimplement it cleanroom. The loss of XFS, JFS, and NUMA is not 
critical, and people can always get patches.
If you guys do this, then SCO won't be able to interfere with Redhat or 
any Linux companies except the ones they
are suing. Darl showed me the undisclosed IP agreements between Novell 
and SCO that are not public, and Novell
**IS** going to lose their Copyright case -- the agreements say they 
sold them to SCO -- period, and for some
reason Novell failed to make copies of the documents which is why they 
don't have them.

Jeff




