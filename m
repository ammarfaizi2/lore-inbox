Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263053AbVCDM4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263053AbVCDM4j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 07:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262932AbVCDMvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 07:51:46 -0500
Received: from [195.23.16.24] ([195.23.16.24]:48004 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262909AbVCDMnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 07:43:50 -0500
Message-ID: <42285804.80401@grupopie.com>
Date: Fri, 04 Mar 2005 12:43:48 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
Cc: Hua Zhong <hzhong@cisco.com>, "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Greg KH'" <greg@kroah.com>, "'David S. Miller'" <davem@davemloft.net>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <200503031842.AWY46304@mira-sjc5-e.cisco.com> <Pine.LNX.4.58.0503031101270.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503031101270.25732@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>[...]
> Ie I'd organize it like some of the "checkin committees" work for other 
> projects that have nowhere _near_ as much work going on as Linux has. That 
> seems to work well for small projects - and we can try to keep this 
> "small" exactly by having the strict rules in place that would mean that 
> 99% of all patches wouldn't even be a consideration.

Maybe setting up a mailing list where all the patches have to be posted 
before inclusion in this tree, would help the maintainer(s) a lot.

Since we expect little traffic (at least compared to LKML) a lot of 
developers (even "small" developers like myself) can review all the 
patches for correctness, and throw quite a few eyes on them. The more 
eyes, the less a chance for bugs to slip by.

Just a thought,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
