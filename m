Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272286AbTHNK3b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Aug 2003 06:29:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272287AbTHNK3b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Aug 2003 06:29:31 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:35300 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S272286AbTHNK3a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Aug 2003 06:29:30 -0400
Message-ID: <3F3B696A.1090801@genebrew.com>
Date: Thu, 14 Aug 2003 06:50:18 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Watts <m.watts@eris.qinetiq.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Via KT400 agpgart issues
References: <200308141025.12747.m.watts@eris.qinetiq.com>
In-Reply-To: <200308141025.12747.m.watts@eris.qinetiq.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Watts wrote:
<snip>
> I'm running a GeForce FX 5600 128Mb with AGP 3.0 support enabled.

AFAIK 2.4.21 does not have AGP 3.0 support. Can you turn that off? If 
not, use a more recent kernel (2.6.x has what you need, not sure about 
2.4.22pre).

Thanks,
Rahul
-- 
Rahul Karnik
rahul@genebrew.com

