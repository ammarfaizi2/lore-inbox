Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268881AbUIQP6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268881AbUIQP6v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:58:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268989AbUIQP6C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:58:02 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:43500 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S268881AbUIQPzD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:55:03 -0400
Message-ID: <414B08C7.3050505@pobox.com>
Date: Fri, 17 Sep 2004 11:54:47 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Florian Schirmer <jolt@tuxbox.org>
CC: Pekka Pietikainen <pp@ee.oulu.fi>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH][1/4] b44: Ignore carrier lost errors
References: <200408292218.00756.jolt@tuxbox.org> <200408292233.03879.jolt@tuxbox.org>
In-Reply-To: <200408292233.03879.jolt@tuxbox.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Florian Schirmer wrote:
> Hi,
> 
> some (?) hardware seems to be buggy and is reporting bogus carrier lost 
> values. Both reference implementations from Broadcom indicate that this 
> counter is not reliable and therefore ignore it. We should do the same. 
> "Fixes" the carrier lost problem i've seen.
> 
> Regards,
>   Florian
> 
> Signed-off-by: Florian Schirmer <jolt@tuxbox.org>

patch applied to 2.6.x


