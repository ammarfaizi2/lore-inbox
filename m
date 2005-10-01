Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbVJAPIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbVJAPIr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Oct 2005 11:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbVJAPIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Oct 2005 11:08:47 -0400
Received: from wproxy.gmail.com ([64.233.184.199]:53003 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750736AbVJAPIr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Oct 2005 11:08:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=qHFcE51gjA6VgUODA55dnkIt05g//g9p76mQl76OFvDKPdTxxAvAarJZljLlnnwbUZWprIWmlZ27Q3A5ACR7qRoY0Yq3M2O0XgTFU6lWtUP7FLxNkKtMLtJ+ncwvyn7yPvS5c1L4ORr69Dkk4/rRLGZsLQOHVJ+rpEcTnXs2owc=
Date: Sat, 1 Oct 2005 19:19:57 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: kernel-janitors@lists.osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc3-kj1
Message-ID: <20051001151957.GA5148@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.14-rc3-kj1 aka "Kaffeine Albatross" is out. You can grab it from
http://coderock.org/kj/2.6.14-rc3-kj1/

Full shortlog is at
http://coderock.org/kj/2.6.14-rc3-kj1/shortlog

New in this release
-------------------
Christophe Lucas
  arch/alpha/kernel/*: use KERN_*       (continued)
  arch/i386/kernel/apic.c: use KERN_*

Dropped
-------
Remove_DRM_ARRAY_SIZE.patch
	DRM people want to keep code of BSD and Linux drivers the same.

Merged
------
drivers_ieee1394_hosts_c_use_time_before.patch

