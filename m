Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVCVAZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVCVAZe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262216AbVCVAXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:23:18 -0500
Received: from fire.osdl.org ([65.172.181.4]:18562 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262213AbVCVAWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:22:25 -0500
Date: Mon, 21 Mar 2005 16:22:14 -0800
From: Andrew Morton <akpm@osdl.org>
To: covici@ccs.covici.com
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org, airlied@linux.ie
Subject: Re: X not working with Radeon 9200 under 2.6.11
Message-Id: <20050321162214.71483708.akpm@osdl.org>
In-Reply-To: <16959.25374.535872.507486@ccs.covici.com>
References: <16937.54786.986183.491118@ccs.covici.com>
	<20050321145301.3511c097.akpm@osdl.org>
	<16959.25374.535872.507486@ccs.covici.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John covici <covici@ccs.covici.com> wrote:
>
> Yep, no fb drivers, but someone did point me in the direction of the
> x.org server and the crash went away using that server.  These are
> unofficial Debian packages -- for more information look at
> http://www.nixnuts.net/files .

It's a bit sad that xfree _used_ to work (2.6.9?) and now it doesn't work,
and the fix is to switch to the x.org server.

Do we know what changed to cause this?  Was it deliberate?
