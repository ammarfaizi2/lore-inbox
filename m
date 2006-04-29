Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWD2CcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWD2CcJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 22:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWD2CcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 22:32:09 -0400
Received: from ozlabs.org ([203.10.76.45]:23259 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750866AbWD2CcI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 22:32:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17490.53283.417700.559725@cargo.ozlabs.ibm.com>
Date: Sat, 29 Apr 2006 12:32:03 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
       cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] NUMA support for spufs
In-Reply-To: <20060429011827.502138000@localhost.localdomain>
References: <20060429011827.502138000@localhost.localdomain>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd Bergmann writes:

> The current version of spufs breaks upon boot when NUMA support is enabled.
> I'd like to fix that before 2.6.17 so we can use the same kernel image
> on Cell that we use on other powerpc systems using NUMA.

Andrew,

If 2/4 of this series looks OK to you to go into 2.6.17, let me know
and I'll push the others to Linus (or you can if you prefer).

Thanks,
Paul.
