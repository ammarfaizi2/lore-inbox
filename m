Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263229AbUC3AJO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 19:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263212AbUC3AJO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 19:09:14 -0500
Received: from dsl081-235-061.lax1.dsl.speakeasy.net ([64.81.235.61]:8359 "EHLO
	ground0.sonous.com") by vger.kernel.org with ESMTP id S263229AbUC3AJJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 19:09:09 -0500
In-Reply-To: <1080604519.32741.8.camel@minerva>
References: <5516F046-81C1-11D8-A0A8-000A959DCC8C@sonous.com> <Pine.LNX.4.53.0403291602340.2893@chaos>  <20040329222710.GA8204@DervishD> <1080604519.32741.8.camel@minerva>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <75D673FF-81DE-11D8-A0A8-000A959DCC8C@sonous.com>
Content-Transfer-Encoding: 7bit
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       DervishD <raul@pleyades.net>, linux-kernel@vger.kernel.org
From: Lev Lvovsky <lists1@sonous.com>
Subject: Re: older kernels + new glibc?
Date: Mon, 29 Mar 2004 16:09:06 -0800
To: Matthew Reppert <repp0017@tc.umn.edu>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mar 29, 2004, at 3:55 PM, Matthew Reppert wrote:
>
> See http://www.kernelnewbies.org/faq/index.php3#headers
>
> The correct place, I've read, to get the headers for the current 
> running
> kernel is /lib/modules/$(uname -r)/build/include ... which of course
> assumes that you keep your kernel in the same place you built it from,
> but that's not a worse assumption than whatever you'd assume for
> /usr/include/{linux,asm} symlinks to work I'm sure.
>
> Basically, the potential problem as I understand it is binary
> incompatibility with the currently installed glibc.
>
> Matt

http://www.ussg.iu.edu/hypermail/linux/kernel/0007.3/0587.html

beautiful, this answers all questions :)

thanks everyone!
-lev

