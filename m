Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267508AbUHYOC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267508AbUHYOC3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 10:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267511AbUHYOC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 10:02:28 -0400
Received: from main.gmane.org ([80.91.224.249]:6810 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267508AbUHYOC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 10:02:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Simon Oosthoek <simon@ti-wmc.nl>
Subject: Re: kernel 2.6.8 pwc patches and counterpatches
Date: Wed, 25 Aug 2004 16:02:17 +0200
Message-ID: <cgi65a$s76$1@sea.gmane.org>
References: <1092793392.17286.75.camel@localhost> <1092845135.8044.22.camel@localhost> <20040823221028.GB4694@kroah.com> <200408250058.24845@smcc.demon.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: darla.ti-wmc.nl
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
In-Reply-To: <200408250058.24845@smcc.demon.nl>
Cc: linux-usb-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nemosoft Unv. wrote:

> Actually, I've got a little surprise for you. The NDA I signed with Philips 
> has already expired a year ago. Yet, I didn't just throw the decompressor 
> code on the Internet. First, there could still be legal remedies since the 
> cams are still in production to this very day. Second, that NDA was signed 
> on a basis of trust and I do not want to lose that trust. I'm looking at 
> the bigger picture here: if we (Linux developers) can show we are 
> trustworthy, we may be able to get better support from hardware 
> manufacturers now and in the future (and really, that's what the kernel is 
> for 75% about ....) I'm still in contact with Philips and who knows, maybe 
> we can get all the source opened up...

I have one of those philips cams (bought it because I saw pwc in the 
kernel source), but I found out that without pwcx is was next to 
useless. I haven't found a good alternative camera though...

The fact that the NDA has expired already doesn't surprise me, but I 
would have expected some (or a huge) effort to liberate the source with 
full permission from Philips (they probably don't care anymore and could 
use the (marginal) good publicity more that the secret).

The fact that this hasn't happened is to me a hint that Nemosoft likes 
the power of "owning" it more that the chance of liberating it. But I 
could be wrong in that... (I apologise in advance if I'm wrong!)

I'd prefer that a clear choice is made on this, as Nemosoft suggests, 
because it shouldn't be in the kernel without the full decoding algorithms.

Cheers

Simon (a user)


