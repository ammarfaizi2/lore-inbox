Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265985AbUBCMIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Feb 2004 07:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265994AbUBCMIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Feb 2004 07:08:15 -0500
Received: from marcoport.ecogen.unibo.it ([137.204.175.100]:1932 "EHLO
	crono.olimpo.ddts.net") by vger.kernel.org with ESMTP
	id S265985AbUBCMIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Feb 2004 07:08:14 -0500
Date: Tue, 3 Feb 2004 13:07:24 +0100
From: Marco Giordani <marco@bononia.it>
To: Hugang <hugang@soulinfo.com>
Cc: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: swsusp2 on ppc [Re: Software Suspend 2.0]
Message-ID: <20040203120724.GA4314@cs.unibo.it>
Mail-Followup-To: Hugang <hugang@soulinfo.com>,
	swsusp-devel <swsusp-devel@lists.sourceforge.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040203093754.194ecba1@localhost>
X-Operating-System: Debian GNU/Linux unstable
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 03, 2004 at 09:37:54AM +0800, Hugang wrote:
> Show us the detail.

I'm sorry, it's my mistake. With the last patch (ppc_up.diff that you
sent on sunday) it works with vanilla 2.6.1. I've tried to merge this
patch with benh's tree but probably I've made some errors. 
Unfortunately I can't use vanilla kernel: it lacks some features that I
need. 

Have you planned to make any patches against benh's tree?

Bye,
marco

-- 
  Marco Giordani <giordani@cs.unibo.it> - GnuPGid 0x229B1BE8/1024
  Key fingerprint = F1C8 CD45 210D 6C19 A5FD  A864 FA01 3E5C 229B 1BE8
