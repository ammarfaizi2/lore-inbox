Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751872AbWJMWGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751872AbWJMWGJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 18:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751850AbWJMWGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 18:06:09 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36070
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751218AbWJMWGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 18:06:07 -0400
Date: Fri, 13 Oct 2006 15:06:08 -0700 (PDT)
Message-Id: <20061013.150608.63128976.davem@davemloft.net>
To: joro-lkml@zlug.org
Cc: jdi@l4x.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/02 V3] net/ipv6: seperate sit driver to extra module
From: David Miller <davem@davemloft.net>
In-Reply-To: <20061013191744.GA30089@zlug.org>
References: <20061010153745.GA27455@zlug.org>
	<452FD6F6.3090907@l4x.org>
	<20061013191744.GA30089@zlug.org>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <joro-lkml@zlug.org>
Date: Fri, 13 Oct 2006 21:17:45 +0200

> On Fri, Oct 13, 2006 at 08:12:06PM +0200, Jan Dittmer wrote:
> > This is missing the MODULE_LICENSE statements and taints the kernel upon
> > loading. License is obvious from the beginning of the file.
 ...
> > Signed-off-by: Jan Dittmer <jdi@l4x.org>
> Signed-off-by: Joerg Roedel <joro-lkml@zlug.org>

Applied, thanks for catching this Jan.
