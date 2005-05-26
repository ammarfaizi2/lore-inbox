Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261638AbVEZRMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261638AbVEZRMT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 13:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261611AbVEZRKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 13:10:31 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:10954 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261631AbVEZRGB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 13:06:01 -0400
Message-ID: <4296019B.8070006@free.fr>
Date: Thu, 26 May 2005 19:04:27 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: george@mvista.com
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
References: <21FFE0795C0F654FAD783094A9AE1DFC07AFE7C1@cof110avexu4.global.avaya.com> <4294D9C6.3060501@mvista.com>
In-Reply-To: <4294D9C6.3060501@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:e39ae1980843c849592344a98bbbf26f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



George Anzinger wrote:
> If you really want millisecond accuracy, you may 
> need to consider another platform....

Are some platform known for the precision of their timers?

Could hardware help? (like a PCI timer card)


