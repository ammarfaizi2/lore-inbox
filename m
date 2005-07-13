Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVGMVfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVGMVfv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 17:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262471AbVGMVeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 17:34:04 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:44651 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S262804AbVGMVbH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 17:31:07 -0400
Date: Wed, 13 Jul 2005 23:18:59 +0000
From: Sam Ravnborg <sam@ravnborg.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Lindent: ignore .indent.pro
Message-ID: <20050713231859.GA28514@mars.ravnborg.org>
References: <20050713155542.GA4264@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713155542.GA4264@locomotive.unixthugs.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2005 at 11:55:42AM -0400, Jeff Mahoney wrote:
> 
>  When I recently submitted a Lindent patch, it turned out that my .indent.pro
>  options were also applied to the tree. This patch directs indent(1) to ignore
>  the .indent.pro directives and only use options specified on the command
>  line.
Applied,

	Sam
