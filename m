Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261580AbULNRv3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261580AbULNRv3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 12:51:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261583AbULNRtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 12:49:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:45190 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261580AbULNRnn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 12:43:43 -0500
Date: Tue, 14 Dec 2004 09:43:37 -0800
From: Chris Wright <chrisw@osdl.org>
To: "Marcos D. Marado Torres" <marado@student.dei.uc.pt>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel scm_send local DoS (fwd)
Message-ID: <20041214094337.O469@build.pdx.osdl.net>
References: <Pine.LNX.4.61.0412141710250.25679@student.dei.uc.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.61.0412141710250.25679@student.dei.uc.pt>; from marado@student.dei.uc.pt on Tue, Dec 14, 2004 at 05:10:56PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Marcos D. Marado Torres (marado@student.dei.uc.pt) wrote:
> Synopsis:  Linux kernel scm_send local DoS
> Product:   Linux kernel
> Version:   2.4 up to and including 2.4.28, 2.6 up to and including 2.6.9

this is already fixed by Herbert Xu in both trees.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
