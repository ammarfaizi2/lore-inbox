Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759173AbWLDDGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759173AbWLDDGo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 22:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759177AbWLDDGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 22:06:44 -0500
Received: from ozlabs.org ([203.10.76.45]:39571 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1759142AbWLDDGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 22:06:43 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17779.37050.4039.942954@cargo.ozlabs.ibm.com>
Date: Mon, 4 Dec 2006 14:06:34 +1100
From: Paul Mackerras <paulus@samba.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Roy Zang <tie-fei.zang@freescale.com>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [2.6 patch] arch/powerpc/Kconfig: fix the EMBEDDED6xx dependencies
In-Reply-To: <20061201115410.GV11084@stusta.de>
References: <20061201115410.GV11084@stusta.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk writes:

> This patch changes the EMBEDDED6xx dependencies to the equivalent 
> dependency that seems to have been intended.

Nack - CONFIG_EMBEDDED6xx is going away entirely, soon.

Paul.
