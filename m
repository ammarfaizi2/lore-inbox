Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269251AbUJWAEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269251AbUJWAEF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 20:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269280AbUJWACE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 20:02:04 -0400
Received: from mail.scl.ameslab.gov ([147.155.137.19]:18126 "EHLO
	mail.scl.ameslab.gov") by vger.kernel.org with ESMTP
	id S269298AbUJWAAT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 20:00:19 -0400
Message-ID: <41799EEF.8060902@scl.ameslab.gov>
Date: Fri, 22 Oct 2004 18:59:43 -0500
From: Troy Benjegerdes <troy@scl.ameslab.gov>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040918)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Roland Dreier <roland@topspin.com>
CC: Francois Romieu <romieu@fr.zoreil.com>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>	<20041009115028.GA14571@electric-eye.fr.zoreil.com> <52oejbliuk.fsf@topspin.com>
In-Reply-To: <52oejbliuk.fsf@topspin.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, fortunately this has turned out to be a non-issue.

I just went to www.infinibandta.org and the 1.2 spec is available for 
download.

http://www.infinibandta.org/specs/register/publicspec/vol1r1_2.zip
http://www.infinibandta.org/specs/register/publicspec/vol2r1_2.zip

Roland Dreier wrote:

>    Roland> it's orthogonal to any IP issues.  Since the Linux kernel
>    Roland> contains a lot of code written to specs available only
>    Roland> under NDA (and even reverse-engineered code where specs
>    Roland> are completely unavailable), I don't think the expense
>    Roland> should be an issue.
>
>    Francois> One can say good bye to peer review.
>
>Yes and no.  Certainly people without specs can't review spec
>compliance, but review for coding style, locking bugs, etc. is if
>anything more valuable.
>
>Thanks,
>  Roland
>_______________________________________________
>openib-general mailing list
>openib-general@openib.org
>http://openib.org/mailman/listinfo/openib-general
>
>To unsubscribe, please visit http://openib.org/mailman/listinfo/openib-general
>  
>

