Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752437AbWCQAWE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbWCQAWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 19:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752451AbWCQAWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 19:22:04 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64436 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1752437AbWCQAWC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 19:22:02 -0500
Message-ID: <441A011A.6010705@pobox.com>
Date: Thu, 16 Mar 2006 19:21:46 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Scott Bardone <sbardone@chelsio.com>
CC: Adrian Bunk <bunk@stusta.de>, maintainers@chelsio.com,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/chelsio/sge.c: two array overflows
References: <20060311013720.GG21864@stusta.de> <4415C87B.90107@chelsio.com>
In-Reply-To: <4415C87B.90107@chelsio.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Scott Bardone wrote:
> Adrian,
> 
> This is a bug. The array should contain 2 elements.
> 
> Attached is a patch which fixes it.
> Thanks.
> 
> Signed-off-by: Scott Bardone <sbardone@chelsio.com>

applied.  please avoid attachments and use a proper patch description in 
the future.  I had to hand-edit and hand-apply your patch.

See http://linux.yyz.us/patch-format.html for more info, or use git.

	Jeff



