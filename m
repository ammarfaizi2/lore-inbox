Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268812AbUJKLhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268812AbUJKLhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:37:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268819AbUJKLhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:37:34 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:22736 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id S268812AbUJKLhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:37:20 -0400
Date: Mon, 11 Oct 2004 13:37:12 +0200
From: Tim Cambrant <cambrant@acc.umu.se>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc4-mm1
Message-ID: <20041011113712.GB10342@shaka.acc.umu.se>
References: <20041011032502.299dc88d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041011032502.299dc88d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: SunOS shaka.acc.umu.se 5.8 Generic_117000-05 sun4u sparc SUNW,Ultra-250 Solaris
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2004 at 03:25:02AM -0700, Andrew Morton wrote:
>
> optimize-profile-path-slightly.patch
>   Optimize profile path slightly
>

I'm still getting an oops at startup with this patch. After reversing
it, everything is fine. Weren't you supposed to remove that from your
tree until it was fixed?


-- 

        Tim Cambrant
     cambrant@acc.umu.se
http://www.acc.umu.se/~cambrant/
