Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964990AbVKVQkZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964990AbVKVQkZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964993AbVKVQkZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:40:25 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:5394 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S964990AbVKVQkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:40:23 -0500
Message-ID: <438349F4.2080405@argo.co.il>
Date: Tue, 22 Nov 2005 18:40:20 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <20051121225303.GA19212@kroah.com> <20051121230136.GB19212@kroah.com> <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org> <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org>
In-Reply-To: <20051122162506.GA32684@havoc.gtf.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 16:40:22.0322 (UTC) FILETIME=[6E7AC120:01C5EF83]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

>On Tue, Nov 22, 2005 at 06:14:56PM +0200, Avi Kivity wrote:
>  
>
>>You exaggerate. Windows drivers work well enough in Windows (or so I 
>>presume). One just has to implement the environment these drivers 
>>expect, very carefully.
>>    
>>
>
>I exaggerate nothing -- we have real world experience with ndiswrapper
>and similar software, which is exactly the same model you proposed, is
>exactly the same model that has created all sorts of technical, legal,
>and political problems.
>  
>
I agree that the legal and political problems are real. I offered two 
solutions to the technical problems.

However the situation with video drivers is already bad, and 
deteriorating. I had to hunt on the Internet to get my recent (FC4) 
distro to support my low-end embedded video (via). In the future it 
looks like even that won't work.

>Dumb with a capital 'D'.
>  
>
I hope you have a better solution.
