Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTGMUHm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 16:07:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270389AbTGMUHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 16:07:42 -0400
Received: from galaxy.lunarpages.com ([64.235.234.165]:8926 "EHLO
	galaxy.lunarpages.com") by vger.kernel.org with ESMTP
	id S263990AbTGMUHk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 16:07:40 -0400
Message-ID: <3F11C278.3040407@genebrew.com>
Date: Sun, 13 Jul 2003 16:35:04 -0400
From: Rahul Karnik <rahul@genebrew.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: agpgart, nforce2, radeon and agp fastwrite
References: <3F102E8E.4030507@portrix.net> <20030712202622.GB7741@suse.de> <3F10793E.5080202@portrix.net> <20030712211721.GA10207@suse.de> <20030713133720.GE19132@mail.jlokier.co.uk>
In-Reply-To: <20030713133720.GE19132@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - galaxy.lunarpages.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - genebrew.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Dave Jones wrote:
> 
>>Girr. I'm not entirely happy about exporting that if I can help it.
>>It's annoying that the nvidia_insert_memory() routine is 99% the same
>>as the generic routine. If it could use that, we'd not have to worry
>>about the export.
> 
> 
> Is it time to teach the module loader how to patch certain binaries? :)

No, this is the NForce AGP module Dave is talking about that NVidia 
contributed.

- Rahul
--
Rahul Karnik
rahul@genebrew.com

