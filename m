Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261248AbVC2Xks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261248AbVC2Xks (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 18:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261649AbVC2Xks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 18:40:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:63715 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261248AbVC2Xki (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 18:40:38 -0500
Subject: Re: Mac mini sound woes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Marcin Dalecki <martin@dalecki.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Takashi Iwai <tiwai@suse.de>
In-Reply-To: <4249E3F4.8070005@nortel.com>
References: <1111966920.5409.27.camel@gaston>
	 <1112067369.19014.24.camel@mindpipe>
	 <4a7a16914e8d838e501b78b5be801eca@dalecki.de>
	 <1112084311.5353.6.camel@gaston>
	 <e5141b458a44470b90bfb2ecfefd99cf@dalecki.de>
	 <1112134385.5386.22.camel@mindpipe>  <4249E3F4.8070005@nortel.com>
Content-Type: text/plain
Date: Wed, 30 Mar 2005 09:39:24 +1000
Message-Id: <1112139564.31848.65.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 17:25 -0600, Chris Friesen wrote:
> Lee Revell wrote:
> 
> > This is the exact line of reasoning that led to Winmodems.
> 
> My main issue with winmodems is not so much the software offload, but 
> rather that the vendors don't release full specs.
> 
> If all winmodem manufacturers released full hardware specs, I doubt 
> people would really complain all that much.  There's a fairly large pool 
> of talent available to write drivers once the interfaces are known.

Look at the pile of junk that are most winmodem driver implementations,
nothing I want to see in the kernel ever. Those things should be in
userland.

Ben.


