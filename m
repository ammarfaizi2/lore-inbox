Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266325AbUAHWNG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 17:13:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266330AbUAHWNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 17:13:06 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:39598 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S266325AbUAHWND (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 17:13:03 -0500
Date: Thu, 8 Jan 2004 23:10:40 +0100
To: Hans Ulrich Niedermann <linux-kernel@n-dimensional.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.1-rc3] Canonically reference files in Documentation/, Documentation/ part
Message-ID: <20040108221040.GB785@mars>
References: <86isjm70wq.fsf@n-dimensional.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86isjm70wq.fsf@n-dimensional.de>
User-Agent: Mutt/1.5.4i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08, 2004 at 07:25:41PM +0100, Hans Ulrich Niedermann wrote:
> diff -Nru a/Documentation/digiepca.txt b/Documentation/digiepca.txt
> --- a/Documentation/digiepca.txt	Thu Jan  8 18:52:40 2004
> +++ b/Documentation/digiepca.txt	Thu Jan  8 18:52:40 2004
> @@ -60,7 +60,7 @@
>  Supporting Tools:
>  -----------------
>  Supporting tools include digiDload, digiConfig, buildPCI, and ditty.  See
> -/usr/src/linux/Documentation/README.epca.dir/user.doc for more details.  Note,
> +Documentation/README.epca.dir/user.doc for more details.  Note,
                 ^^^^^^^^^^^^^^^^^^^^^^^^
Non-existent.

-- 
Linux is a true multitasking system. Are you?
