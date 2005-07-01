Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263363AbVGAOvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263363AbVGAOvd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 10:51:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263364AbVGAOvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 10:51:33 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:7297 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S263363AbVGAOva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 10:51:30 -0400
Message-ID: <2442.192.167.206.189.1120229488.squirrel@new.host.name>
In-Reply-To: <20050701131950.GA15180@ime.usp.br>
References: <20050629001847.GB850@frodo>
    <200506290453.HAA14576@raad.intranet>
    <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org>
    <42C4FC14.7070402@slaphack.com> <20050701092412.GD2243@suse.de>
    <20050701131950.GA15180@ime.usp.br>
Date: Fri, 1 Jul 2005 16:51:28 +0200 (CEST)
Subject: Re: XFS corruption during power-blackout
From: "Luigi Genoni" <genoni@darkstar.linuxpratico.net>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.5.1 [CVS]
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

problem can be that most disk become too slow to be usable if cache is
disabled.


On Fri, July 1, 2005 15:19, Rogério Brito wrote:
> On Jul 01 2005, Jens Axboe wrote:
>
>> On Fri, Jul 01 2005, David Masover wrote:
>>
>>> Not always possible.  Some disks lie and leave caching on anyway.
>>>
>>
>> And the same (and others) disks will not honor a flush anyways.
>> Moral of that story - avoid bad hardware.
>>
>
> But how does the end-user know what hardware is "good hardware"? Which
> vendors don't lie (or, at least, lie less than others) regarding HDs?
>
>
> Thanks, Rogério Brito.
>
>
> --
> Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
> Homepage of the algorithms package : http://algorithms.berlios.de
> Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>  the body of a message to majordomo@vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

