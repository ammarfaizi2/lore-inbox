Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267431AbUHYRkK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267431AbUHYRkK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 13:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268182AbUHYRkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 13:40:10 -0400
Received: from waste.org ([209.173.204.2]:33928 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S267431AbUHYRkB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 13:40:01 -0400
Date: Wed, 25 Aug 2004 12:39:42 -0500
From: Matt Mackall <mpm@selenic.com>
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org, bcasavan@sgi.com
Subject: Re: [PATCH] kallsyms data size reduction / lookup speedup
Message-ID: <20040825173941.GJ5414@waste.org>
References: <1093406686.412c0fde79d4f@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093406686.412c0fde79d4f@webmail.grupopie.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2004 at 05:04:46AM +0100, pmarques@grupopie.com wrote:
> 
> As always, comments, suggestions, flames will be greatly appreciated :)

Please post patches inline so they're easier to comment on.
Attachments are a nuisance.

Am I correct that this is completely replacing stem compression with
your substring dictionary approach?

-- 
Mathematics is the supreme nostalgia of our time.
