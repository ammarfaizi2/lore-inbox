Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261218AbVF2PBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261218AbVF2PBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVF2PBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:01:07 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:20911 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S261218AbVF2PBF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:01:05 -0400
Subject: Re: Linux 2.6.13-rc1 - bad tag in git tree?
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
Content-Type: text/plain
Date: Wed, 29 Jun 2005 10:01:00 -0500
Message-Id: <1120057260.9321.22.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

$ cat refs/tags/v2.6.13-rc1
733ad933f62e82ebc92fed988c7f0795e64dea62

This object doesn't appear to be in the git tree.
-- 
David Kleikamp
IBM Linux Technology Center


