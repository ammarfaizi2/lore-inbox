Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267918AbUH2ORH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267918AbUH2ORH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 10:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUH2ORH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 10:17:07 -0400
Received: from the-village.bc.nu ([81.2.110.252]:55936 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267893AbUH2ORE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 10:17:04 -0400
Subject: Re: [Fwd: Re: pwc+pwcx is not illegal]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Mike Keehan <mike_keehan@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040828183617.79096.qmail@web12303.mail.yahoo.com>
References: <20040828183617.79096.qmail@web12303.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093785303.27934.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 29 Aug 2004 14:15:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm making no comment on the legal question as to whether its a
derivative work. The kernel policy for video capture has always been
that format conversion belongs in user space. In other words PWCX should
be returning compressed bits to user space and the pwc compression is a
userspace library anyway

