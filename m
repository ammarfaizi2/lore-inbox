Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161062AbVKXKpt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbVKXKpt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 05:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVKXKps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 05:45:48 -0500
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:40838 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S1030383AbVKXKpn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 05:45:43 -0500
Date: Thu, 24 Nov 2005 11:45:36 +0100
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Autoclean of modules
Message-Id: <20051124114536.7dcb61b6.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-sun-solaris2.7)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Until a few minutes ago I assumed that modules that have been inserted
automatically or by "modprobe -k" into the kernel are being removed by
calling "rmmod -a" twice if these modules are unused. But I just
realized that this works neither with kernel 2.4.30 nor with kernel
2.6.11.12.

So, what is the matter with autoclean of modules?

Regards
  Christoph
