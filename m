Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030305AbVIVNE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030305AbVIVNE3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 09:04:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbVIVNE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 09:04:28 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:11427 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1030299AbVIVNE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 09:04:27 -0400
Message-ID: <4332ABDC.3030106@rtr.ca>
Date: Thu, 22 Sep 2005 09:04:28 -0400
From: Mark Lord <liml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, Joshua Kwan <joshk@triplehelix.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: SATA suspend-to-ram patch - merge?
References: <433104E0.4090308@triplehelix.org> <433221A1.5000600@pobox.com> <20050922061849.GJ7929@suse.de>
In-Reply-To: <20050922061849.GJ7929@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>So currently we are in limbo...
> 
> Which is a shame, since it means that software suspend on sata is
> basically impossible :)

Except that it actually does work, with Jen's patch.

Rather than sitting around for another six months hoping the problem
will go away (it won't), perhaps we should just update/merge Jen's
patch as a sorely needed interim fix.

This might then prod James et al into looking more at the SCSI side of
things, and some year we might see this get replaced with a better scheme.

This is a real problem, and an immediate solution is needed last spring.

Cheers

