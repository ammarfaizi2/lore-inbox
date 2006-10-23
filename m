Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752050AbWJWWeF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752050AbWJWWeF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 18:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752051AbWJWWeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 18:34:05 -0400
Received: from xenotime.net ([66.160.160.81]:8916 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1752050AbWJWWeD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 18:34:03 -0400
Date: Mon, 23 Oct 2006 15:35:40 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: sam@ravnborg.org
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: CHECK without C compile?
Message-Id: <20061023153540.4d467a88.rdunlap@xenotime.net>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

Is there an option/variant of CHECKSRC that does something like
	make checkall
i.e., runs CHECK=sparse on all source files, without also building them
with the C compiler?

Thanks,
---
~Randy
