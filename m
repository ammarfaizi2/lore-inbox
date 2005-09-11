Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965034AbVIKSuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965034AbVIKSuA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 14:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965039AbVIKSuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 14:50:00 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:7659
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965034AbVIKSt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 14:49:59 -0400
Date: Sun, 11 Sep 2005 11:50:01 -0700 (PDT)
Message-Id: <20050911.115001.07438655.davem@davemloft.net>
To: Ralf.Hildebrandt@charite.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: assertion errors with 2.6.13-git10
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050911163714.GG19734@charite.de>
References: <20050911163714.GG19734@charite.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
Date: Sun, 11 Sep 2005 18:37:14 +0200

> With 2.6.13-git10 I get a lot of these when running amule; after a
> while, the machine locks up hard:

Should be fixed in the GIT tree as of yesterday.
