Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSFJMh4>; Mon, 10 Jun 2002 08:37:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313505AbSFJMhz>; Mon, 10 Jun 2002 08:37:55 -0400
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:4620 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S313202AbSFJMhx>; Mon, 10 Jun 2002 08:37:53 -0400
Date: Mon, 10 Jun 2002 22:40:05 +1000
From: john slee <indigoid@higherplane.net>
To: Giuliano Pochini <pochini@shiny.it>
Cc: Dawson Engler <engler@csl.Stanford.EDU>, linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 54 missing null pointer checks in 2.4.17
Message-ID: <20020610124005.GM27429@higherplane.net>
In-Reply-To: <200206100607.XAA17282@csl.Stanford.EDU> <XFMail.20020610091911.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 09:19:11AM +0200, Giuliano Pochini wrote:
> 
> > which means there are indeed bugs in jbd, just not the one we flagged ;-)
> 
> I was wondering what toold you use to catch these bugs... What is jbd ?

journalling block device.  part of the kernel, not the checker.  the
checker is a hacked up gcc i believe.  wonderful stuff.

j.

-- 
toyota power: http://indigoid.net/
