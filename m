Return-Path: <linux-kernel-owner+w=401wt.eu-S1750778AbXAOOxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbXAOOxp (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 09:53:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbXAOOxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 09:53:45 -0500
Received: from luna.alliedvisiontec.com ([213.203.238.80]:59043 "EHLO
	luna.alliedvisiontec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbXAOOxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 09:53:44 -0500
Subject: Re: ieee1394 feature needed: overwrite SPLIT_TIMEOUT from userspace
From: Philipp Beyer <philipp.beyer@alliedvisiontec.com>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
In-Reply-To: <45AB8A5E.7040006@s5r6.in-berlin.de>
References: <1168602157.5074.4.camel@ahr-pbe-lx.avtnet.local>
	 <tkrat.0ae1f576575bc02e@s5r6.in-berlin.de>
	 <1168867271.5190.9.camel@ahr-pbe-lx.avtnet.local>
	 <45AB8A5E.7040006@s5r6.in-berlin.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 Jan 2007 15:54:30 +0100
Message-Id: <1168872870.5190.18.camel@ahr-pbe-lx.avtnet.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I will now try to work around this problem in userspace basically by
> > ignoring the timeout error.
> 
> I.e. something similar but less sophisticated than the protocol 01...09?
> 

In fact steps 01-09 describe what I had in mind pretty well :-) 
