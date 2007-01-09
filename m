Return-Path: <linux-kernel-owner+w=401wt.eu-S1750825AbXAIA4Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbXAIA4Y (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 19:56:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750830AbXAIA4Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 19:56:24 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:28239 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825AbXAIA4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 19:56:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mRBOYzQxl7QBwX4MYroJTwoQeq9/S32WBGzqPy7OhlTPz4DupMisGk51u9Y6paF66Fnieetv+q/CEfFhFHuBhUViYDOi7aiFdkakjAnNmbSbxXhIZULhlLW/bI+EWuNLvQk0w1WGbh1WTiUvskxdVd5Qup/E2i2++X9qyWCskdQ=
Message-ID: <215036450701081656u189774ffv46440f50031668eb@mail.gmail.com>
Date: Tue, 9 Jan 2007 08:56:22 +0800
From: "Joe Jin" <lkmaillist@gmail.com>
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: BUG: sleeping function called from invalid context at kernel/rwsem.c:20
Cc: linux-kernel@vger.kernel.org, "Ingo Molnar" <mingo@elte.hu>,
       "Arjan van de Ven" <arjan@linux.intel.com>
In-Reply-To: <20070106024139.GM20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <215036450612201907p1b7b1eddg42014578bd4db33e@mail.gmail.com>
	 <20070106024139.GM20714@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/6/07, Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Dec 21, 2006 at 11:07:27AM +0800, Joe Jin wrote:
> Thanks for your report.
>
> Is this issue still present in kernel 2.6.20-rc3?
> And was it already present in kernel 2.6.19?

It is not  occur again, just appeared this time.
At 2.6.19 never found it.
and now I'm running 2.6.20-rc3, dont occur to now

Thanks

-- 
Regards,
Joe Jin
