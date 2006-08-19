Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWHSAP7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWHSAP7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 20:15:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422664AbWHSAP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 20:15:58 -0400
Received: from xenotime.net ([66.160.160.81]:44232 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422663AbWHSAP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 20:15:57 -0400
Date: Fri, 18 Aug 2006 17:18:57 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Bjo Breiskoll" <bjo@nefkom.net>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
       zanussi@us.ibm.com
Subject: Re: Relay-Subsystem
Message-Id: <20060818171857.6cd7e6c0.rdunlap@xenotime.net>
In-Reply-To: <000501c6c321$58d1a830$03b2a8c0@bjoserver>
References: <000501c6c321$58d1a830$03b2a8c0@bjoserver>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Aug 2006 01:52:21 +0200 Bjo Breiskoll wrote:

> Is there an updated description about the new relay-subsystem
> available? The old relayfs.h is gone and you made quite a few
> changes. The whole examples-tarball from
> http://sourceforge.net/projects/relayfs wont work. (And i need
> blocking-relayfile IO.) :-)

When I updated Documentation/filesystems/relayfs.txt recently,
Jens advised me that it needs lots of work.  I was hoping that
Tom Zanussi would get around to doing that.
For a current working example, see block/blktrace.c.

---
~Randy
