Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264931AbUF1Wqx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264931AbUF1Wqx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265270AbUF1Wqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:46:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:3476 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S264931AbUF1Wqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:46:50 -0400
Date: Tue, 29 Jun 2004 00:42:51 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: David Eger <eger@havoc.gtf.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.7-mm3] cirrusfb: minor fixes
Message-ID: <20040629004251.A25515@electric-eye.fr.zoreil.com>
References: <20040626233105.0c1375b2.akpm@osdl.org> <20040628212727.A23504@electric-eye.fr.zoreil.com> <20040628215948.GA12415@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040628215948.GA12415@havoc.gtf.org>; from eger@havoc.gtf.org on Mon, Jun 28, 2004 at 05:59:48PM -0400
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Eger <eger@havoc.gtf.org> :
[...]
> On another note...
> pci_request_regions() replaces request_mem_region()... 

Oops, I forgot to include it in the description of the patch.

> looks like virtually all of the FB drivers have suffered from bit
> rot.

It is not the closest target but it's on the radar.

--
Ueimor
