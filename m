Return-Path: <linux-kernel-owner+w=401wt.eu-S1751119AbXAILLd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbXAILLd (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 06:11:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbXAILLd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 06:11:33 -0500
Received: from wr-out-0506.google.com ([64.233.184.239]:4402 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119AbXAILLc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 06:11:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cKfKcwJmWGVaIJaiFY269K3b3RYsDJ7nJAp96dIVTcd8mab+C0WDsbjp/cAv8jumCqJ0pyMHKzgNBgPHBB8PbVmiHkEdbs4/Cs2TSvUFS496VPZb+e952exuOJ0sAqWWkcjx2OOP3HULet+jIsBxrWv9sVgwSAABlQGELVjhusk=
Message-ID: <6f61137b0701090311gb82f392l626973b11d8911e9@mail.gmail.com>
Date: Tue, 9 Jan 2007 12:11:31 +0100
From: "Maarten Vanraes" <maarten.vanraes@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: AHCI IDENTIFY problem only on x86_64
Cc: "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <45A37497.6020505@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <6f61137b0701090235g2ea3f4a2j2d5e985ef70b142a@mail.gmail.com>
	 <45A371E3.9090103@garzik.org>
	 <6f61137b0701090247l6077cbb8k91eec388779c33cd@mail.gmail.com>
	 <45A37497.6020505@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

so, the problem is already solved then? at what minimal kernel version
was that problem solved?

i didn't see it in the changelogs, but i may not have seen them all...

If i know the version, i can submit the info to them...

2007/1/9, Jeff Garzik <jeff@garzik.org>:
> Maarten Vanraes wrote:
> > i don't think so, but i cannot test it... i don't have an x86_64
> > system, and i cannot install on my disk, cause it's not detected.
> > unless i can install an x86_64 kernel on a i586 system, i donno how to
> > further test this.
>
> If you are stopped at the initial install, just grab a distro that
> already works on this hardware, like Fedora Core 6 (x86-64).
>
>         Jeff
>
>
>
>


-- 
Alien is my name and head-biting is my game
