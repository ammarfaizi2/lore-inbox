Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVDELzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDELzM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 07:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbVDELzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 07:55:12 -0400
Received: from [195.23.16.24] ([195.23.16.24]:37853 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S261701AbVDELzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 07:55:08 -0400
Message-ID: <42527C99.5010300@grupopie.com>
Date: Tue, 05 Apr 2005 12:55:05 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paulo Marques <pmarques@grupopie.com>
Cc: Adrian Bunk <bunk@stusta.de>, LKML <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] create a kstrdup library function
References: <42519911.508@grupopie.com> <20050404211531.GH4087@stusta.de> <425273CF.3090807@grupopie.com>
In-Reply-To: <425273CF.3090807@grupopie.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Marques wrote:
> Adrian Bunk wrote:
> 
>> This patch contains a small bug:
>>[...]
> Andrew, do you want me to send a new patch with this fixed, so you can 
> back out the current one and apply the new one, or can you simply merge 
> this one from Adrian?

Never mind, I can see the fix is already in rc2-mm1.

Thanks,

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
