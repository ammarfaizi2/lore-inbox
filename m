Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265211AbUIIPO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265211AbUIIPO4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 11:14:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265462AbUIIPO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 11:14:56 -0400
Received: from a26.t1.student.liu.se ([130.236.221.26]:19926 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S265211AbUIIPOz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 11:14:55 -0400
Message-ID: <4140736A.90301@drzeus.cx>
Date: Thu, 09 Sep 2004 17:14:50 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040704)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ISA DMA
References: <413F7960.8070500@drzeus.cx> <1094682435.12335.23.camel@localhost.localdomain>
In-Reply-To: <1094682435.12335.23.camel@localhost.localdomain>
X-Enigmail-Version: 0.84.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>drivers/net/lance.c is a pretty good worked example of driving the old
>ISA bus grunge. 
>
>  
>
Thanks. That helped solve some of the problems at least. The transfers 
still only work some of the time. Everything seems ok but only junk in 
the buffers. Not sure which part is causing it so it'll require some 
more research.

Rgds
Pierre
