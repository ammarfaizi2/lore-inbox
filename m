Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264126AbTLXXeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 18:34:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264128AbTLXXeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 18:34:15 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:16348 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S264126AbTLXXeO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 18:34:14 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Stan Bubrouski <stan@ccs.neu.edu>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 24 Dec 2003 15:34:01 -0800 (PST)
Subject: Re: is it possible to have a kernel module with a BSD license?!
In-Reply-To: <20031224221024.GA6438@matchmail.com>
Message-ID: <Pine.LNX.4.58.0312241510150.7586@dlang.diginsite.com>
References: <3FE9ADEE.1080103@baywinds.org> <1072303285.2947.215.camel@duergar>
 <20031224221024.GA6438@matchmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the question comes back to looking if it's derived from the linux kernel.

if it is then it must be GPL (GPL doesn't allow anything else)

if it isn't then it can be becouse the GPL is compatable with BSD code.
(it becomes GPL for purposes of the kernel, but is also available for
other uses under the BSD license)

however the big question as always remains 'is this derived from the
kernel code'

David Lang


On Wed, 24 Dec 2003, Mike Fedyk wrote:

> Date: Wed, 24 Dec 2003 14:10:24 -0800
> From: Mike Fedyk <mfedyk@matchmail.com>
> To: Stan Bubrouski <stan@ccs.neu.edu>
> Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
> Subject: Re: is it possible to have a kernel module with a BSD license?!
>
> On Wed, Dec 24, 2003 at 05:01:25PM -0500, Stan Bubrouski wrote:
> > Why would anyone want to BSD license a kernel module, honestly...
>
> to work with *BSD?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
