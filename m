Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWGRVzd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWGRVzd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:55:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWGRVzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:55:33 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58010
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932148AbWGRVzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:55:32 -0400
Date: Tue, 18 Jul 2006 14:55:55 -0700 (PDT)
Message-Id: <20060718.145555.32724710.davem@davemloft.net>
To: jesper.juhl@gmail.com
Cc: linux-kernel@vger.kernel.org, paulkf@microgate.com
Subject: Re: 2.6.18-rc2 allyesconfig doesn't build - undefined references
 to hdlc_set_carrier
From: David Miller <davem@davemloft.net>
In-Reply-To: <200607182352.40222.jesper.juhl@gmail.com>
References: <200607182352.40222.jesper.juhl@gmail.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesper Juhl <jesper.juhl@gmail.com>
Date: Tue, 18 Jul 2006 23:52:39 +0200

> Just tried an allyesconfig build of 2.6.18-rc2 and it fails with this error : 

There is a fix for this already sitting in the net-2.6 GIT
tree, which will be pushed to Linus when he returns.
