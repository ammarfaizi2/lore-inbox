Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSFJSXG>; Mon, 10 Jun 2002 14:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315630AbSFJSXF>; Mon, 10 Jun 2002 14:23:05 -0400
Received: from arsenal.visi.net ([206.246.194.60]:26357 "EHLO visi.net")
	by vger.kernel.org with ESMTP id <S315629AbSFJSXE>;
	Mon, 10 Jun 2002 14:23:04 -0400
Date: Mon, 10 Jun 2002 14:14:18 -0400
From: Ben Collins <bcollins@debian.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: Firewire Disks. (fwd)
Message-ID: <20020610181418.GA496@blimpo.internal.net>
In-Reply-To: <Pine.LNX.3.95.1020610141042.17451B-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 02:11:21PM -0400, Richard B. Johnson wrote:
> 
> 
> ---------- Forwarded message ----------
> From: "Richard B. Johnson" <root@chaos.analogic.com>
> Subject: Firewire Disks.
> 
> I know there is support for "firewire" in the kernel. Is there
> support for "firewire" disks? If so, how do I enable it?
> 
> Cheers,
> Dick Johnson

Compile and/or install the sbp2 module.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://linux1394.sourceforge.net/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
