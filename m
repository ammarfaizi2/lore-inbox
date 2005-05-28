Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVE1CN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVE1CN0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 22:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbVE1CNZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 22:13:25 -0400
Received: from mail.dvmed.net ([216.237.124.58]:9954 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262668AbVE1CNT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 22:13:19 -0400
Message-ID: <4297D3B4.1070809@pobox.com>
Date: Fri, 27 May 2005 22:13:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Netdev <netdev@oss.sgi.com>
CC: James Ketrenos <jketreno@linux.intel.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: netdev-2.6.git updated, ipw wireless drivers merged
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The ipw 2100/2200 wireless drivers were merged into the netdev-2.6.git 
repository, under the 'we18-ieee80211' branch.

There is also the we18-ieee80211-wifi branch, which lumps HostAP on top 
of that.

(if you need info on git, read http://lkml.org/lkml/2005/5/26/11)

Also, Andrew:  I fixed that compilation error you mentioned a week or so 
ago.


