Return-Path: <linux-kernel-owner+w=401wt.eu-S932886AbXATC4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932886AbXATC4o (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 21:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932883AbXATC4n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 21:56:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:17100 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932869AbXATC4m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 21:56:42 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q91ZRzHqov1UMQq2x7YW0dFIZwhZ2uFEHOLqYleI9dbYuYJY4qiFphuAS+0Y4Ihf4yDVrJEIT454Jo4kHiKDJWt9dUEHTekBr/qhsVItV3ad7KGrKMXuGrM44dsNOv77BwydO2LnTznHINXGv7qN3yxGyyiOyfrlWL/q9ci1tO0=
Message-ID: <8355959a0701191856t5cadf684jdabb939d103de020@mail.gmail.com>
Date: Sat, 20 Jan 2007 08:26:40 +0530
From: "Sunil Naidu" <akula2.shark@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: Realtime-preemption for 2.6.20-rc5 ?
Cc: linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20070118101949.GA22671@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <8355959a0701180215s7824cea5m20a5d7b95d80c0e@mail.gmail.com>
	 <20070118101949.GA22671@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/18/07, Ingo Molnar <mingo@elte.hu> wrote:
> the best place to start is:
>
>   http://rt.wiki.kernel.org
>
>         Ingo

I did refer the same. Is it necessary to use only base kernel, say
2.6.19? Or, can I go ahead with 2.6.19 + 2.6.19.2 patch + 2.6.19-rt
patch?

If yes, any reason why we need to apply rt patch only to a base kernel?

Thanks,

~Akula2
