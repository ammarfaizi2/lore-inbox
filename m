Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161145AbVKRTFV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161145AbVKRTFV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 14:05:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbVKRTFU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 14:05:20 -0500
Received: from mail.dvmed.net ([216.237.124.58]:39367 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161137AbVKRTFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 14:05:18 -0500
Message-ID: <437E25EA.1080609@pobox.com>
Date: Fri, 18 Nov 2005 14:05:14 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-ide@vger.kernel.org
CC: Brett Russ <bruss@alum.wpi.edu>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
References: <20051114050404.GA18144@havoc.gtf.org>	 <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>	 <4379F31D.4000508@pobox.com>	 <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>	 <437D2DED.5030602@pobox.com> <f990dfce0511180537i4becb5f1k611a58874e9bf972@mail.gmail.com> <437DFC66.3040209@pobox.com>
In-Reply-To: <437DFC66.3040209@pobox.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Brett Russ wrote:
>> -the version # of sata_mv doesn't look like it was bumped.  Did I miss 
>> it?
> 
> 
> That was intentional:  since sata_mv just went upstream in this upcoming 
> release (2.6.15), the version number was already bumped.

Nevertheless, I needed to add Red Hat to the copyright, so I used that 
as an excuse to update the version to 0.5...

	Jeff



