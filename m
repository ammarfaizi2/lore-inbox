Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTEPGzW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 02:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbTEPGzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 02:55:22 -0400
Received: from ns.suse.de ([213.95.15.193]:64520 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264334AbTEPGzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 02:55:22 -0400
Date: Fri, 16 May 2003 09:08:13 +0200
From: Andi Kleen <ak@suse.de>
To: Roland McGrath <roland@redhat.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [x86_64 PATCH] IA32 vsyscall DSO compatibility in IA32_EMULATION
Message-ID: <20030516070813.GA11846@Wotan.suse.de>
References: <200305152239.h4FMdaX12112@magilla.sf.frob.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305152239.h4FMdaX12112@magilla.sf.frob.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 15, 2003 at 03:39:36PM -0700, Roland McGrath wrote:
> Btw, 2.5 ia32 core dumping on x86-64 as is crashes without the patch I just
> posted to lkml.

Check out ftp://ftp.x86-64.org/pub/linux/v2.5/x86_64-2.5.69-4.bz2

You did duplicate work.

-Andi
