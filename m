Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266449AbUHNLEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266449AbUHNLEs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 07:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266450AbUHNLEs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 07:04:48 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:23729 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S266449AbUHNLEr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 07:04:47 -0400
Message-ID: <411DF183.1040906@rtr.ca>
Date: Sat, 14 Aug 2004 07:03:31 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: age huisman <ahuisman@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux SATA RAID FAQ
References: <411B0F45.8070500@pobox.com> <20040812113413.GA19252@alpha.home.local> <411D5D70.9070909@clanhk.org> <411D8444.9030403@rtr.ca> <cfkc03$ejo$1@news.cistron.nl>
In-Reply-To: <cfkc03$ejo$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

age huisman wrote:
> TCQ ?   What about NCQ?  :-)

Both kinds of SATA command-queuing will be included.\,
whatever the name/abbreviation.

hdparm support as well (a first for SATA/SCSI).

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
