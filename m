Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030394AbWFISyW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030394AbWFISyW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 14:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWFISyW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 14:54:22 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:44949 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030389AbWFISyV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 14:54:21 -0400
Message-ID: <4489C3D5.4030905@garzik.org>
Date: Fri, 09 Jun 2006 14:54:13 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: Mike Snitzer <snitzer@gmail.com>
CC: Andrew Morton <akpm@osdl.org>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, ext2-devel@lists.sourceforge.net,
       cmm@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] [RFC 0/13] extents and 48bit ext3
References: <1149816055.4066.60.camel@dyn9047017069.beaverton.ibm.com>	 <20060609091327.GA3679@infradead.org>	 <20060609030759.48cd17a0.akpm@osdl.org> <44899653.1020007@garzik.org>	 <20060609095620.22326f9d.akpm@osdl.org> <4489AAD9.80806@garzik.org>	 <20060609103543.52c00c62.akpm@osdl.org> <4489B452.4050100@garzik.org>	 <4489B719.2070707@garzik.org> <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com>
In-Reply-To: <170fa0d20606091127h735531d1s6df27d5721a54b80@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.2 (----)
X-Spam-Report: SpamAssassin version 3.1.1 on srv5.dvmed.net summary:
	Content analysis details:   (-4.2 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Snitzer wrote:
> On 6/9/06, Jeff Garzik <jeff@garzik.org> wrote:
>> Jeff Garzik wrote:
>> > I disagree completely...  it would be an obvious win:  people who want
>> > stability get that, people who want new features get that too.
>>
>> And developers have a better outlet for their wacky developmental 
>> urges...
> 
> And no real-world near-term progress is made for production users with
> modern requirements. What you're advocating breeds instability in the
> near-term.

Constantly patching the main, "stable" Linux filesystem breeds 
instability today.

	Jeff



