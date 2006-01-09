Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161257AbWAIAW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161257AbWAIAW4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965356AbWAIAW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:22:56 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:38040 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965010AbWAIAWz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:22:55 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=bnpljoH16fK6MwUFdVySs5ql/CMP49wwl2CYvn1/cTaYa5b77qi8pPIUQIiQiBsHHhg/eSJBWYZjJBR9DSwO4ReV0rC9wOPpLrN5LiUVFWinCBAADAMxmdpP4NGa8scZU2cEtSKs2Rv8vi4E6MfNzgZ6ry9yxofU/y7O/5rDtAU=
Message-ID: <43C1ACB4.4030704@gmail.com>
Date: Mon, 09 Jan 2006 08:22:12 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: intelfb
References: <20060108234839.GF3001@mail.muni.cz> <20060108235753.GR3774@stusta.de>
In-Reply-To: <20060108235753.GR3774@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, Jan 09, 2006 at 12:48:40AM +0100, Lukas Hejtmanek wrote:
> 
>> Hello,
> 
> Hi Lukas,
> 
>> is someone developing intelfb driver? Or is it some old (maybe functional) code?
> 
> the MAINTAINERS file in the kernel sources says:
> 
> INTEL 810/815 FRAMEBUFFER DRIVER
> P:      Antonino Daplas
> M:      adaplas@pol.net
> L:      linux-fbdev-devel@lists.sourceforge.net
> S:      Maintained
> 

I maintain i810fb.  The author and maintainer of intelfb for 2.6 is Sylvain
Meyer. For 2.4, the author is David Dawes.

> 
> Antonino is quite active and whatever your question/problem is he's the 
> best contact for.

Yes, I accept patches for this driver. I also make changes for this
driver as long as the change does not deal with the hardware to deeply.

Tony
