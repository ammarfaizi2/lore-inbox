Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263717AbTKFQzs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 11:55:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263718AbTKFQzs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 11:55:48 -0500
Received: from hockin.org ([66.35.79.110]:43269 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S263717AbTKFQzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 11:55:43 -0500
Date: Thu, 6 Nov 2003 08:46:14 -0800
From: Tim Hockin <thockin@hockin.org>
To: Ian Kent <raven@themaw.net>
Cc: Mike Waychison <Michael.Waychison@Sun.COM>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Your increase minor device patch
Message-ID: <20031106164614.GA21098@hockin.org>
References: <Pine.LNX.4.44.0311062138380.2962-100000@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0311062138380.2962-100000@raven.themaw.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 06, 2003 at 09:46:41PM +0800, Ian Kent wrote:
> Your patch looks good. It's simple enough to verify correctness. With 
> all the work that has been done already on the minor device number 
> enlargment in 2.6 it seems a shame that this final piece is not yet 
> in the kernel tree.

I'd like to seea sysctl controlled version, but with a bit of cleanup (or
maube as is -- need to re-read it) it is 'safe' for 2.6.0.  Linus may
disagree, and we all have to admit that it is not 'stabilization' but a
feature.

No harm waiting for 2.6.1, though we should get it posted publicly as a
pending patch.


-- 
Notice that as computers are becoming easier and easier to use,
suddenly there's a big market for "Dummies" books.  Cause and effect,
or merely an ironic juxtaposition of unrelated facts?

