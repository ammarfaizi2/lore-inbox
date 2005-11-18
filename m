Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbVKRB1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbVKRB1S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 20:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVKRB1S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 20:27:18 -0500
Received: from mail.dvmed.net ([216.237.124.58]:52416 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751339AbVKRB1R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 20:27:17 -0500
Message-ID: <437D2DED.5030602@pobox.com>
Date: Thu, 17 Nov 2005 20:27:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
CC: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
References: <20051114050404.GA18144@havoc.gtf.org> <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de> <4379F31D.4000508@pobox.com> <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>
In-Reply-To: <Pine.LNX.4.63.0511152108140.3015@dingo.iwr.uni-heidelberg.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See if you can give the latest git tree a try (what will be 
2.6.15-rc1-git6, later tonight).  I think I've killed most of the 
sata_mv bugs, and have it working here on both 50xx and 60xx.

	Jeff


