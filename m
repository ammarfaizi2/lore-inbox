Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268889AbUIHG6f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268889AbUIHG6f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 02:58:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268890AbUIHG63
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 02:58:29 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:1114 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S268889AbUIHGzj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 02:55:39 -0400
Date: Wed, 8 Sep 2004 10:55:45 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Olaf Hering <olh@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove tmpfile for ppc binutils check
Message-ID: <20040908085545.GA8821@mars.ravnborg.org>
Mail-Followup-To: Olaf Hering <olh@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040907195719.GB14276@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040907195719.GB14276@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 07, 2004 at 09:57:19PM +0200, Olaf Hering wrote:
> 
> make distclean does not remove the new tmp file .tmp_gas_check.
> 
> Signed-off-by: Olaf Hering <olh@suse.de>

Applied to my tree - thanks.

	Sam
