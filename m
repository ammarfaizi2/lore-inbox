Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTKJNfm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 08:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262781AbTKJNfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 08:35:42 -0500
Received: from uni03du.unity.ncsu.edu ([152.1.13.103]:27008 "EHLO
	uni03du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S262687AbTKJNfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 08:35:38 -0500
From: jlnance@unity.ncsu.edu
Date: Mon, 10 Nov 2003 08:35:36 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Some thoughts about stable kernel development
Message-ID: <20031110133536.GA1780@ncsu.edu>
References: <m3u15de669.fsf@defiant.pm.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3u15de669.fsf@defiant.pm.waw.pl>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> There is a problem that a development cycle (time between stable
> = non-pre/rc versions) is long.

This sentiment is expressed fairly often, and I have never seen it challenged.
However, I am not convinced that it is true.  I do not believe that people
who care about stability want to upgrade to a new kernel with major changes
in it every 9 months.  It also takes a fairly long time for our "stable"
kernels to actually get stable enough that vendors are comfortable shipping
them.  I think if our develpment cycle gets significantly shorter, you will
end up with vendors skipping entire stable series (ie. moving from 2.2 to 2.6
without ever doing 2.4).  I think that would create more pain for us than our
current release cycle length does.

Thanks,

Jim
