Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264990AbUETH2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264990AbUETH2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 May 2004 03:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265029AbUETH2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 May 2004 03:28:12 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:48157 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S264990AbUETH2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 May 2004 03:28:09 -0400
Date: Thu, 20 May 2004 09:39:51 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Davidlohr Bueso A <dbueso@linuxchile.cl>
Cc: linux-kernel@vger.kernel.org, Larry McVoy <lm@work.bitmover.com>,
       '@ravnborg.org
Subject: Re: bk repository
Message-ID: <20040520073951.GA2210@mars.ravnborg.org>
Mail-Followup-To: Davidlohr Bueso A <dbueso@linuxchile.cl>,
	linux-kernel@vger.kernel.org, Larry McVoy <lm@work.bitmover.com>,
	'@ravnborg.org
References: <1085025662.1032.10.camel@offworld>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085025662.1032.10.camel@offworld>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 20, 2004 at 12:01:02AM -0400, Davidlohr Bueso A wrote:
> When will the 2.6 branch be added to the bitkeeper resository?
It's alrweady there, but with a bit mis-leading name.
bk://linux.bkbits.net/linux-2.5

To see the repository in your browser use:
http://linux.bkbits.net and select the linux-2.5 repository.

The reason to keep the linux-2.5 name is simply that renaming the repository
would cause parent information to be void for all people pulling
from this directory.

To my knowledge there is no possibility to symlink two repositories, so
both names could live in parrallel for a while??

	Sam
