Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262349AbTKJB7K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Nov 2003 20:59:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbTKJB7K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Nov 2003 20:59:10 -0500
Received: from waste.org ([209.173.204.2]:31887 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262349AbTKJB7I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Nov 2003 20:59:08 -0500
Date: Sun, 9 Nov 2003 19:59:05 -0600
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110015905.GN13246@waste.org>
References: <20031107051048.GA6099@work.bitmover.com> <bollnv$uvt$1@cesium.transmeta.com> <20031109152534.GA24312@work.bitmover.com> <3FAE9576.9080007@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAE9576.9080007@zytor.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 09, 2003 at 11:28:54AM -0800, H. Peter Anvin wrote:
> Larry McVoy wrote:
> >On Sun, Nov 09, 2003 at 07:16:15AM -0800, H. Peter Anvin wrote:
> >
> >>That doesn't include anyone who uses the mirrored repository on the
> >>main kernel.org machines.  
> >
> >Last I checked, kernel.org isn't offering pserver access, just ftp.  If you
> >want to take over the CVS access just say the word.
> >
> 
> No, we don't do the pserver access, but some people get the whole 
> repository through the mirror.  The current division seems to work well, 
> so I don't see any reason to change it.

Except for the higher likelihood of pserver being an exploit vector.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
