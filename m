Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267511AbUIOEgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267511AbUIOEgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 00:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267526AbUIOEgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 00:36:47 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:2515 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267511AbUIOEgp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 00:36:45 -0400
Message-ID: <4147C6D6.30508@nortelnetworks.com>
Date: Tue, 14 Sep 2004 22:36:38 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andreas Dilger <adilger@clusterfs.com>
CC: "Martin J. Bligh" <mbligh@aracnet.com>, Anton Blanchard <anton@samba.org>,
       Linux kernel <linux-kernel@vger.kernel.org>, paulus@samba.org
Subject: Re: offtopic: how to break huge patch into smaller independent patches?
References: <41474B15.8040302@nortelnetworks.com> <20040915002023.GD5615@krispykreme> <119340000.1095209242@flay> <414799D1.7050609@nortelnetworks.com> <20040915014711.GA30607@schnapps.adilger.int>
In-Reply-To: <20040915014711.GA30607@schnapps.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:

> Consider using a source-control tool next time ;-/.  

We used a source control tool.  Its just not very useful when people do a port 
from one kernel version to the next and submit it as one giant patch against the 
new kernel rather than new versions of the original individual patches.

I'm the one planning how to avoid this problem in our next development cycle.

Chris
