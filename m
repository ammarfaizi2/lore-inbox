Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVGRL3o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVGRL3o (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Jul 2005 07:29:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbVGRL3o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Jul 2005 07:29:44 -0400
Received: from [195.23.16.24] ([195.23.16.24]:36006 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261569AbVGRL3j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Jul 2005 07:29:39 -0400
Message-ID: <42DB92A0.6090600@grupopie.com>
Date: Mon, 18 Jul 2005 12:29:36 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: Sam Ravnborg <sam@ravnborg.org>, "J.A. Magallon" <jamagallon@able.es>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] signed char fixes for scripts
References: <1121465068l.13352l.0l@werewolf.able.es> <1121465683l.13352l.5l@werewolf.able.es> <20050716095216.GB8064@mars.ravnborg.org> <42DB8F7B.30100@grupopie.com>
In-Reply-To: <42DB8F7B.30100@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> Sam Ravnborg wrote:
> [...]
>> Also this patch seems relative small compared to the others floating
>> around to cure signed warnings in scripts/
>> Does this really fix all of them or only a subset of the warnings?
> 
> Well, current -linus already has a patch from me to change the 
                 ^^^^^^
I meant -mm... :P

-- 
Paulo Marques - www.grupopie.com

It is a mistake to think you can solve any major problems
just with potatoes.
Douglas Adams
