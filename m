Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262406AbUIDNlo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262406AbUIDNlo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 09:41:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbUIDNlo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 09:41:44 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:7812 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S262406AbUIDNk0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 09:40:26 -0400
Message-ID: <4139C56C.7080808@rtr.ca>
Date: Sat, 04 Sep 2004 09:38:52 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Tomasz Torcz <zdzichu@irc.pl>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: md RAID over SATA performance
References: <1094169937l.17931l.0l@werewolf.able.es> <41389CDA.5060609@rtr.ca> <20040903202717.GD4075@irc.pl>
In-Reply-To: <20040903202717.GD4075@irc.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hdparm-5.7 has this feature.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")

Tomasz Torcz wrote:
> On Fri, Sep 03, 2004 at 12:33:30PM -0400, Mark Lord wrote:
> 
>>Unless O_DIRECT is used (hdparm --direct), in which case they
> 
> 
>  In which version of hdparm? I'm using 5.6 (I believe it's latest) which
> doesn't know --direct switch.
> 

