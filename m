Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWEWPlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWEWPlz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 11:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbWEWPly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 11:41:54 -0400
Received: from smtpout.mac.com ([17.250.248.183]:61914 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750748AbWEWPly (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 11:41:54 -0400
In-Reply-To: <1148395433.25255.66.camel@localhost.localdomain>
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com> <44700ACC.8070207@gmail.com> <A78F7AE7-C3C2-43DA-9F17-D196CCA7632A@mac.com> <1148379089.25255.9.camel@localhost.localdomain> <4472E3D8.9030403@garzik.org> <83B4C39B-1A5E-4734-A5FF-10C3179B535B@mac.com> <1148395433.25255.66.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ADF9B4F7-2B6E-41B7-8B83-26261EBE27F7@mac.com>
Cc: Jeff Garzik <jeff@garzik.org>, Manu Abraham <abraham.manu@gmail.com>,
       linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: OpenGL-based framebuffer concepts
Date: Tue, 23 May 2006 11:41:38 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 23, 2006, at 10:43:53, Alan Cox wrote:
> You've no idea how a GPU works have you ?
>
> [snipped eloquent description of how wrong I was]
>
> The GPU view of the universe is far far from the OpenGL one. With  
> the possible exception of the big 3D Labs cards anyway.

Not really, no.  My understanding is basically client-only, aside  
from looking at the Open Graphics Project prototype rendering model a  
bit.  As far as I can see from the discussions and models publicly  
available they are targeting a certain OpenGL standard for their  
card, although I can see I must have misunderstood what that really  
means.

So a modern GPU is essentially a proprietary CPU with an obscure  
instruction set and lots of specialized texel hardware?  Given the  
total lack of documentation from either ATI or NVidia about such  
cards I'd guess it's impossible for Linux to provide any kind of  
reasonable 3d engine for that kind of environment, and it might be  
better to target a design like the Open Graphics Project is working  
to provide.

Cheers,
Kyle Moffett


