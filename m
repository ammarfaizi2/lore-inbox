Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbVHCFRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbVHCFRS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 01:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVHCFRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 01:17:18 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:17454 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262056AbVHCFRQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 01:17:16 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.95,162,1120428000"; 
   d="scan'208"; a="13515670:sNHT26907328"
Message-ID: <42F05359.7030006@fujitsu-siemens.com>
Date: Wed, 03 Aug 2005 07:17:13 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
       linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: ahci, SActive flag, and the HD activity LED
References: <42EF93F8.8050601@fujitsu-siemens.com> <20050802163519.GB3710@suse.de>
In-Reply-To: <20050802163519.GB3710@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

>>If I am reading the specs correctly, that'd mean the ahci driver is 
>>wrong in setting the SActive bit.
> 
> I completely agree, that was my reading of the spec as well and hence my
> original posts about this in the NCQ thread.

Have you (or has anybody else) also seen the wrong behavior of the 
activity LED?

Regards
Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
