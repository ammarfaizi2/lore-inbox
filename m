Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbVF2NLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbVF2NLm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 09:11:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262112AbVF2NLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 09:11:42 -0400
Received: from [213.170.72.194] ([213.170.72.194]:3811 "EHLO
	shelob.oktetlabs.ru") by vger.kernel.org with ESMTP id S262574AbVF2NLO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 09:11:14 -0400
Message-ID: <42C29DEE.3030100@oktetlabs.ru>
Date: Wed, 29 Jun 2005 17:11:10 +0400
From: "Artem B. Bityuckiy" <dedekind@oktetlabs.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en, ru, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Matthew Gilbert <mgilbert@mvista.com>
Subject: Re: [PATCH] Documentation: Kernel Initialization Mechanisms
References: <1119894357.7998.15.camel@localhost.localdomain>
In-Reply-To: <1119894357.7998.15.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will it go to the kernel ?

Matthew Gilbert wrote:
> Below is documentation I've started on the kernel initialization
> mechanisms. Other than reading the source, I haven't been able to find
> much discussion on the topic. 
> 
> My explanations of the different init levels is lacking. I haven't been
> able to find any documentation on them. Existing usage seems to vary
> quite a bit so its hard to tell their intended functionality. I was
> hoping to get some help defining what the intended usage was. Especially
> regarding what services are available at each level.
> 
> Feedback is appreciated. Thanks _matt
> 
> Signed-off-by: Matthew Gilbert <mgilbert@mvista.com>
> 
> --- linux-2.6.12.1/Documentation/initcalls.txt.orig	1969-12-31 17:00:00.000000000 -0700
> +++ linux-2.6.12.1/Documentation/initcalls.txt	2005-06-24 16:58:45.232683368 -0700
> @@ -0,0 +1,120 @@
> +===============================
> +Linux Initialization Mechanisms
> +===============================
> +
> +__initcall
> +----------
... [snip] ...


-- 
Best regards, Artem B. Bityuckiy
Oktet Labs (St. Petersburg), Software Engineer.
+78124286709 (office) +79112449030 (mobile)
E-mail: dedekind@oktetlabs.ru, web: http://www.oktetlabs.ru
