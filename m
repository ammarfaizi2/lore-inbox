Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbUKRM4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbUKRM4D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbUKRM4C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:56:02 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:35021 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262702AbUKRMz7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:55:59 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-fbdev-devel@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] [PATCH: 2.6.10-rc2] fbdev: Fix rivafb breakage (typo introduced by cset 1.2563)
Date: Thu, 18 Nov 2004 12:55:50 +0000
User-Agent: KMail/1.7
Cc: "Antonino A. Daplas" <adaplas@hotpop.com>,
       Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
References: <200411181239.18093.andrew@walrond.org>
In-Reply-To: <200411181239.18093.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411181255.50965.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixing this typo cures the screen corruption I was seeing on both 32 and 64bit 
x86_64 kernels.

Thanks for the help tracking this down. Please apply!

Andrew Walrond
