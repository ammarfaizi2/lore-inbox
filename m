Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262775AbTKEKSK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Nov 2003 05:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262787AbTKEKSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Nov 2003 05:18:10 -0500
Received: from madrid10.amenworld.com ([62.193.203.32]:28687 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S262775AbTKEKSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Nov 2003 05:18:08 -0500
Date: Wed, 5 Nov 2003 12:17:50 +0100
From: DervishD <raul@pleyades.net>
To: "Prakash K. Cheemplavam" <prakashkc@gmx.de>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
Message-ID: <20031105111750.GJ275@DervishD>
References: <3FA69CDF.5070908@gmx.de> <20031105084007.GZ1477@suse.de> <3FA8C916.3060702@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3FA8C916.3060702@gmx.de>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Prakash :)

 * Prakash K. Cheemplavam <prakashkc@gmx.de> dixit:
> well I am using k3b0.10.1 and either choosing cdrdao or cdrecord in 
> DAO mode to burn the cd ends up in non-bit identical copies, wheres ion 
> TAO (atleast with my 10x CD-RW I tested) the copy succeded. I tried 
> several times, and always got this issue.

    Just FYI, I've had a similar problem a couple of days ago, and,
after a lot of testing I discovered that the problem was in the
motherboard. Try to isolate the problem: use the recorder in another
machine to see if that solves the problem (the recorder may be
damaged and may fail in DAO mode. Strange, but...). Check the cabling
and use another motherboard, or even another OS to do the burning in
DAO mode to see that it fails. And have a look at cdrdao, may the
problem is a cdrecord issue (don't think so, but...) :??

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
