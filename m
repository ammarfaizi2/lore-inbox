Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVIJMYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVIJMYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 08:24:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbVIJMYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 08:24:22 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:17495 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S1750787AbVIJMYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 08:24:21 -0400
Date: Sat, 10 Sep 2005 14:25:54 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] adjust .version updating
Message-ID: <20050910122554.GC18845@mars.ravnborg.org>
References: <43206FD70200007800024459@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43206FD70200007800024459@emea1-mh.id2.novell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2005 at 05:07:35PM +0200, Jan Beulich wrote:
> (Note: Patch also attached because the inline version is certain to get
> line wrapped.)
> 
> In order to maintain a more correct build number, updates to the
> version
> number should only be commited after a successful link of vmlinux, not
> before (so that errors in the link process don't lead to pointless
> increments).

Applied - thanks.
	
	Sam
