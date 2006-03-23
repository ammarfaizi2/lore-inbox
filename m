Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWCWBah@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWCWBah (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 20:30:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932478AbWCWBah
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 20:30:37 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:6045 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932470AbWCWBag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 20:30:36 -0500
Message-ID: <4421FA37.4050703@pobox.com>
Date: Wed, 22 Mar 2006 20:30:31 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Pavlic <fpavlic@de.ibm.com>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [patch 2/6] s390: qeth driver statistics fixes
References: <20060322160339.4e6cf34e@localhost.localdomain>
In-Reply-To: <20060322160339.4e6cf34e@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -2.6 (--)
X-Spam-Report: SpamAssassin version 3.0.5 on srv5.dvmed.net summary:
	Content analysis details:   (-2.6 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frank Pavlic wrote:
> [patch 2/6] s390: qeth driver statistics fixes 
> 
> From: Ursula Braun <braunu@de.ibm.com>
> 	- display "unsigned int" values in /proc/qeth_perf with %u instead of %i
> 	- omit qdio header length when increasing card->stats.tx_bytes
> 
> Signed-off-by: Frank Pavlic <fpavlic@de.ibm.com>

applied 2-4

I am OK with removing tty from network driver (patches 5-6), but they 
didn't apply


