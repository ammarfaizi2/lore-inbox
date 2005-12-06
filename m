Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbVLFTll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbVLFTll (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 14:41:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030213AbVLFTll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 14:41:41 -0500
Received: from mail.dvmed.net ([216.237.124.58]:32152 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030212AbVLFTlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 14:41:40 -0500
Message-ID: <4395E962.2060309@pobox.com>
Date: Tue, 06 Dec 2005 14:41:22 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
CC: Brian Gerst <bgerst@didntduck.org>, Arjan van de Ven <arjan@infradead.org>,
       "M." <vo.sinh@gmail.com>, Andrea Arcangeli <andrea@suse.de>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org>	 <20051205121851.GC2838@holomorphy.com>	 <20051206011844.GO28539@opteron.random> <43944F42.2070207@didntduck.org>	 <20051206030828.GA823@opteron.random>	 <f0cc38560512060307m2ccc6db8xd9180c2a1a926c5c@mail.gmail.com>	 <1133869465.4836.11.camel@laptopd505.fenrus.org>	 <4394ECA7.80808@didntduck.org>  <4395E2F4.7000308@pobox.com> <1133897867.29084.14.camel@mindpipe>
In-Reply-To: <1133897867.29084.14.camel@mindpipe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Lee Revell wrote: > On Tue, 2005-12-06 at 14:13 -0500,
	Jeff Garzik wrote: >>Let's hope the rev-eng people do it the right way,
	by having one team >>write a document, and a totally separate team
	write the driver from >>that document. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell wrote:
> On Tue, 2005-12-06 at 14:13 -0500, Jeff Garzik wrote:
>>Let's hope the rev-eng people do it the right way, by having one team 
>>write a document, and a totally separate team write the driver from
>>that document.

> Isn't it also legal for a single person or team to capture all IO
> to/from the device with a bus analyzer or kernel debugger and write a
> driver from that, as long as you don't disassemble the original driver?

It's still legally shaky.  The "Chinese wall" approach I described above 
is beyond reproach, and that's where Linux needs to be.

	Jeff


