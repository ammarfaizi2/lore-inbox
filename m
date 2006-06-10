Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbWFJQZa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbWFJQZa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 12:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbWFJQZ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 12:25:29 -0400
Received: from wr-out-0506.google.com ([64.233.184.227]:7498 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751560AbWFJQZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 12:25:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oj5eDLS4pf/BLsJ35i6W50Uy3QQ+VSDZ8pYBOqzEyzL2u6a/TGet9c6/mSRWmkP7j8MVS5VAOGTvAiFNSo4W6fZiKtiZsut3yGlQa+MDEMKC5hfw1I8cYOwewtkbYqbmG6DJmpum4xExnfMILPrLit02gE+3tUJ00arIqjWOVOk=
Message-ID: <6bffcb0e0606100925s2577fb25he22bd4ee086a6234@mail.gmail.com>
Date: Sat, 10 Jun 2006 18:25:28 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Dominik Karall" <dominik.karall@gmx.net>
Subject: Re: 2.6.16-rc6-mm2
Cc: "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200606101818.34952.dominik.karall@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060609214024.2f7dd72c.akpm@osdl.org>
	 <200606101818.34952.dominik.karall@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/06/06, Dominik Karall <dominik.karall@gmx.net> wrote:
> On Saturday, 10. June 2006 06:40, Andrew Morton wrote:
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.1
> >7-rc6/2.6.17-rc6-mm2/
>
> Hi Andrew!
>
> 2.6.17-rc6-mm2 and -mm1 don't boot on my amd64 machine. When I select
> the kernel in grub my computer reboots.
>
> config, cpuinfo and lspci can be found at:
> http://stud4.tuwien.ac.at/~e0227135/kernel/

Please try to disable SMP and PREEMPT.

>
> hth,
> dominik

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
