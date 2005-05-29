Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbVE2Orm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbVE2Orm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 May 2005 10:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261333AbVE2Orm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 May 2005 10:47:42 -0400
Received: from relay1.tiscali.de ([62.26.116.129]:11505 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S261330AbVE2Ori
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 May 2005 10:47:38 -0400
Message-ID: <4299D52B.5080907@tiscali.de>
Date: Sun, 29 May 2005 16:43:55 +0200
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, David Teigland <teigland@redhat.com>,
       linux-kernel@vger.kernel.org, Patrick Caulfield <pcaulfie@redhat.com>
Subject: Re: 2.6.12-rc5-mm1: drivers/dlm/: compile error with gcc 2.95
References: <20050525134933.5c22234a.akpm@osdl.org> <20050529143818.GB10441@stusta.de>
In-Reply-To: <20050529143818.GB10441@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> <--  snip  -->
> 
> ...
>   CC      drivers/dlm/lock.o
> [ .. ]
> make[2]: *** [drivers/dlm/lock.o] Error 1
> 
> <--  snip  -->
> 
> cu
> Adrian
> 
The gcc 2.95 is deprecated, so I think this is not a real problem.

Matthias-Christian Ott
