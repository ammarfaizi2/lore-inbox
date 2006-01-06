Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932642AbWAFWTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932642AbWAFWTX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 17:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932640AbWAFWTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 17:19:23 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:33671
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932577AbWAFWTW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 17:19:22 -0500
Date: Fri, 06 Jan 2006 14:18:36 -0800 (PST)
Message-Id: <20060106.141836.41371212.davem@davemloft.net>
To: dlang@digitalinsight.com
Cc: kaber@trash.net, marcel@holtmann.org, mbuesch@freenet.de,
       jgarzik@pobox.com, bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Bcm43xx-dev] [Fwd: State of the Union: Wireless]
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.62.0601061414570.334@qynat.qvtvafvgr.pbz>
References: <1136549423.7429.88.camel@localhost>
	<43BE6697.3030009@trash.net>
	<Pine.LNX.4.62.0601061414570.334@qynat.qvtvafvgr.pbz>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Lang <dlang@digitalinsight.com>
Date: Fri, 6 Jan 2006 14:16:17 -0800 (PST)

> character devices are far easier to script. this really sounds like the 
> type of configuration stuff that sysfs was designed for. can we avoid yet 
> another configuration tool that's required?

netlink is being recommended exactly because it can result
in only needing one tool for everything
