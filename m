Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261203AbVFPVee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261203AbVFPVee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 17:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVFPVee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 17:34:34 -0400
Received: from lyle.provo.novell.com ([137.65.81.174]:30272 "EHLO
	lyle.provo.novell.com") by vger.kernel.org with ESMTP
	id S261203AbVFPVed (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 17:34:33 -0400
Date: Thu, 16 Jun 2005 14:34:25 -0700
From: Greg KH <gregkh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix compile errors and warning after devfs removal patches
Message-ID: <20050616213425.GA12995@suse.de>
References: <20050611074327.GA27785@kroah.com> <20050611201444.GM3770@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050611201444.GM3770@stusta.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2005 at 10:14:44PM +0200, Adrian Bunk wrote:
> The patch below fixes three compile errors and one compile warning after 
> applying the devfs removal patches.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

Thanks a lot, I've incorporated these into my patch series.

greg k-h
