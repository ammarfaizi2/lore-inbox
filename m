Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUHCBBC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUHCBBC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 21:01:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUHCBAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 21:00:45 -0400
Received: from the-village.bc.nu ([81.2.110.252]:51641 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264767AbUHCBAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 21:00:39 -0400
Subject: Re: [2.6 patch] let 4KSTACKS depend on EXPERIMENTAL (fwd)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040803004509.GW2746@fs.tum.de>
References: <20040802225951.GR2746@fs.tum.de>
	 <20040802162846.3929e463.akpm@osdl.org>  <20040803004509.GW2746@fs.tum.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091490958.1647.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 00:56:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2004-08-03 at 01:45, Adrian Bunk wrote:
> OTOH, at least XFS is known to have problems with 4kb stacks - and you 
> don't want such problems to occur in production environments.

So put && !4KSTACKS in the XFS configuration ?

