Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVHLFpK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVHLFpK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Aug 2005 01:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbVHLFpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Aug 2005 01:45:10 -0400
Received: from mail.dvmed.net ([216.237.124.58]:23466 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751100AbVHLFpI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Aug 2005 01:45:08 -0400
Message-ID: <42FC375C.3040304@pobox.com>
Date: Fri, 12 Aug 2005 01:45:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob van Nieuwkerk <robn@berrymount.nl>
CC: Linux IDE Mailing List <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: SATA status report updated
References: <42FC2EF8.7030404@pobox.com> <20050812074012.60487882.robn@berrymount.nl>
In-Reply-To: <20050812074012.60487882.robn@berrymount.nl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob van Nieuwkerk wrote:
> On Fri, 12 Aug 2005 01:09:12 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> Hi Jeff,
> 
> 
>>Things in SATA-land have been moving along recently, so I updated the 
>>software status report:
>>
>>	http://linux.yyz.us/sata/software-status.html
> 
> 
> Is any progress made on SMART support ?
> I've been reading "SMART support will be integrated very soon"
> for a very long time now .. :-)

True enough :/

It's been feature-complete for a while, but the reports from testers in 
the field have made me too nervous to push it into the upstream kernel.

I might push it upstream, but disable it by default, which would allow 
for a wider test audience.

	Jeff



