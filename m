Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUGGOfu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUGGOfu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 10:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbUGGOfu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 10:35:50 -0400
Received: from waldorf.cs.uni-dortmund.de ([129.217.4.42]:4078 "EHLO
	waldorf.cs.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265161AbUGGOfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 10:35:40 -0400
Date: Wed, 7 Jul 2004 16:35:35 +0200
From: Christoph Pleger <Christoph.Pleger@uni-dortmund.de>
To: linux-kernel@vger.kernel.org
Subject: Address space for user process
Message-Id: <20040707163535.02323a8f.Christoph.Pleger@uni-dortmund.de>
Organization: Universitaet Dortmund
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; sparc-sun-solaris2.6)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I read that - at least in Kernel 2.4 - the amount of memory that can be
addressed by a user process is limited to 3 GB, no matter how much
virtual memory is present. Is it possible to raise that limit?

Kind regards
  Christoph
