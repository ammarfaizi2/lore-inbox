Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262336AbVCCRCy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262336AbVCCRCy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:02:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVCCQ7J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:59:09 -0500
Received: from fire.osdl.org ([65.172.181.4]:10928 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262210AbVCCQ6L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:58:11 -0500
Date: Thu, 3 Mar 2005 08:59:29 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Jeff Garzik <jgarzik@pobox.com>, "David S. Miller" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering 
In-Reply-To: <200503031644.j23Gi0Eh011165@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.58.0503030855460.25732@ppc970.osdl.org>
References: <200503031644.j23Gi0Eh011165@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 3 Mar 2005, Horst von Brand wrote:
> 
> [I'm pulling bk daily, and have it mixed with the ipw tree too, so I'm just
>  the kind of tester you are looking for... haven't seen any of the
>  showstopper bugs everybody is talking about, or I'd have screamed.]

Yeah, I wish everybody was like that. Sadly, it seems to be pretty rare to
have people do weekly builds, much less daily. Daily builds is the holy
grail for me, if just a small percentage of people did that, we'd be
really well off.. Right not it's not even a "percentage", it's a very much
self-selected small group of people, usually with what ends up actually
being fairly similar high-end PC hardware.

Now, I haven't actually gotten any complaints about 2.6.11 (apart from 
"gcc4 still has problems" with fairly trivial solutions), so maybe the 
whole cycle really worked out well this time, and I happened to choose a 
really bad time to bring up this discussion. Or maybe this discussion 
scared away people, and I just need to give it another week or two ;)

		Linus
