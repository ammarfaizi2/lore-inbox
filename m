Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751562AbVHZM76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751562AbVHZM76 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 08:59:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751566AbVHZM75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 08:59:57 -0400
Received: from dgate2.fujitsu-siemens.com ([217.115.66.36]:62240 "EHLO
	dgate2.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S1751559AbVHZM75 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 08:59:57 -0400
X-SBRSScore: None
Message-ID: <430F1238.2020608@fujitsu-siemens.com>
Date: Fri, 26 Aug 2005 14:59:36 +0200
From: Martin Wilck <martin.wilck@fujitsu-siemens.com>
Organization: Fujitsu Siemens Computers
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: de, en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       "Wichert, Gerhard" <Gerhard.Wichert@fujitsu-siemens.com>
Subject: Re: [PATCH] Fix HD activity LED with ahci
References: <42EF93F8.8050601@fujitsu-siemens.com>	 <20050802163519.GB3710@suse.de>  <42F05359.7030006@fujitsu-siemens.com> <1123092761.3982.20.camel@lynx.auton.cs.cmu.edu> <42F1BE18.9000105@fujitsu-siemens.com> <430955FC.9080106@pobox.com>
In-Reply-To: <430955FC.9080106@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> To answer the question everybody was asking, this line was in the code 
> because it was in the patch that got AHCI working.
> 
> I'm inclined to apply the above patch, but I'll wait until 2.6.13, so 
> that we can get some decent testing.

Great. As far as the testing is concerned, we have had no problems with 
the patch here.

Thanks, Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1        mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy
