Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266546AbUAWHpv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 02:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266550AbUAWHpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 02:45:51 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:54249 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id S266546AbUAWHpt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 02:45:49 -0500
Message-ID: <4010CF63.8000608@t-online.de>
Date: Fri, 23 Jan 2004 08:38:11 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Oberritter <obi@saftware.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1 on ATI Rage 128 M3: some thin vertical lines show up
References: <401034E6.70703@t-online.de> <1074805972.2081.85.camel@shiva.eth.saftware.de>
In-Reply-To: <1074805972.2081.85.camel@shiva.eth.saftware.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: GW01SwZboeBOWSgqpy0AH7hvpOyRNq4y35tu3Nw7IfxxbXNjHvf4kY
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Oberritter wrote:

> 
> Just to clarify, are you talking about vesafb? I ask, because the
> rage128 driver included in the kernel does not support flat panels.

Yes, its vesafb. The Rage128 drivers have been compiled as a module,
but they are not loaded.


Regards

Harri
