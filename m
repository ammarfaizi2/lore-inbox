Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUGVUpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUGVUpU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 16:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267235AbUGVUpT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 16:45:19 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:39816 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261474AbUGVUnu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 16:43:50 -0400
Date: Fri, 23 Jul 2004 00:44:35 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scripts/genksyms/parse.c_shipped needs to be rebuilt
Message-ID: <20040722224435.GA9561@mars.ravnborg.org>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <jeacxsl5iw.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jeacxsl5iw.fsf@sykes.suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 22, 2004 at 12:07:03PM +0200, Andreas Schwab wrote:
> parse.c_shipped has never been regenerated after parse.y has been modified
> 4 months ago.

Added to my local kbuild tree.
Thanks.

	Sam
