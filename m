Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965030AbVLFTOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbVLFTOU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965032AbVLFTOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:14:20 -0500
Received: from mail.dvmed.net ([216.237.124.58]:5272 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S965030AbVLFTOT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:14:19 -0500
Message-ID: <4395E2F4.7000308@pobox.com>
Date: Tue, 06 Dec 2005 14:13:56 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Arjan van de Ven <arjan@infradead.org>, "M." <vo.sinh@gmail.com>,
       Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <20051205121851.GC2838@holomorphy.com>	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>	 <20051206030828.GA823@opteron.random>	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com> <1133869465.4836.11.camel@laptopd505.fenrus.org> <4394ECA7.80808@didntduck.org>
In-Reply-To: <4394ECA7.80808@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Brian Gerst wrote: > Once again I'd like to point out
	that user's purchase power means jack > when they only have two choices
	for video: ATI and Nvidia. You can't > walk into a computer store and
	find anything else (I don't count > integrated video on the motherboard
	as a solution, since only Intel > boards have it, sorry AMD users).
	Even over the web it's hard to find > anything else. I'm not trying to
	defend closed source here, but you > people just have to face the
	reality that trying to use the market to > get our way is just not
	going to work with video. The only way forward > is reverse
	engineering. We aren't going to get help from the vendors so > we have
	to help ourselves. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:
> Once again I'd like to point out that user's purchase power means jack 
> when they only have two choices for video:  ATI and Nvidia.  You can't 
> walk into a computer store and find anything else (I don't count 
> integrated video on the motherboard as a solution, since only Intel 
> boards have it, sorry AMD users).  Even over the web it's hard to find 
> anything else.  I'm not trying to defend closed source here, but you 
> people just have to face the reality that trying to use the market to 
> get our way is just not going to work with video.  The only way forward 
> is reverse engineering.  We aren't going to get help from the vendors so 
> we have to help ourselves.

It sure looks that way.

Let's hope the rev-eng people do it the right way, by having one team 
write a document, and a totally separate team write the driver from that 
document.

	Jeff


