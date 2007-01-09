Return-Path: <linux-kernel-owner+w=401wt.eu-S1751177AbXAIL2e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751177AbXAIL2e (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 06:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbXAIL2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 06:28:34 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:7124 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751177AbXAIL2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 06:28:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bB4lHKINCYSck3qpQjwJQxhEFZeNvelu9nHIjg2iLOWE5FqS6eCIzfNgJZlf1le1mBgk7QsnuTBhfBPvIEjy7nxvb1JoAkRQaX5sTF45ftfTb8gbaJjywibncEVzUtjxXmVjQiqn5zdFQKlR3vIZnpbHA9yjrH/slL4vtsnJKL4=
Message-ID: <6f61137b0701090328r1a99db06s7c687b1a40e40bdd@mail.gmail.com>
Date: Tue, 9 Jan 2007 12:28:32 +0100
From: "Maarten Vanraes" <maarten.vanraes@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: AHCI IDENTIFY problem only on x86_64
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45A37A9B.2000505@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6f61137b0701090235g2ea3f4a2j2d5e985ef70b142a@mail.gmail.com>
	 <45A371E3.9090103@garzik.org>
	 <6f61137b0701090247l6077cbb8k91eec388779c33cd@mail.gmail.com>
	 <45A37497.6020505@garzik.org>
	 <6f61137b0701090311gb82f392l626973b11d8911e9@mail.gmail.com>
	 <45A37A9B.2000505@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, fine, but it is fixed, you are sure?

i'll mention it to the people then.

thanks

2007/1/9, Jeff Garzik <jeff@garzik.org>:
> Maarten Vanraes wrote:
> > so, the problem is already solved then? at what minimal kernel version
> > was that problem solved?
> >
> > i didn't see it in the changelogs, but i may not have seen them all...
> >
> > If i know the version, i can submit the info to them...
>
> The SATA drivers have seen /hundreds/ of changes since your kernel was
> released, and the problem you describe is a symptom of /multiple/
> problems that were fixed in the following kernels.
>
> It's unfortunately your task, and the task of the 2.6.16.* maintainer,
> to track this down further if you care.  Most developers concentrate on
> the current kernel, otherwise we wind up fixing the same bugs over and
> over again.
>
> That's what distros pay people to do, care about older kernels...
>
>         Jeff
>
>
>
>


-- 
Alien is my name and head-biting is my game
