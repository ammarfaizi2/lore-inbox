Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937547AbWLENXk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937547AbWLENXk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937548AbWLENXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:23:40 -0500
Received: from ra.tuxdriver.com ([70.61.120.52]:2346 "EHLO ra.tuxdriver.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937547AbWLENXj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:23:39 -0500
Date: Tue, 5 Dec 2006 08:23:05 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: -mm merge plans for 2.6.20
Message-ID: <20061205132259.GA19629@tuxdriver.com>
References: <20061204204024.2401148d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2006 at 08:40:24PM -0800, Andrew Morton wrote:

> hostap-replace-kmallocmemset-with-kzalloc.patch
> prism54-replace-kmallocmemset-with-kzalloc.patch
> ipw2200-replace-kmallocmemset-with-kcalloc.patch
> softmac-fix-unbalanced-mutex_lock-unlock-in-ieee80211softmac_wx_set_mlme.patch
> 
>  Not sent to John - I forgot.

I've got them, and I plan to merge them.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
