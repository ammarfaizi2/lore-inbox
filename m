Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264761AbUEJRpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264761AbUEJRpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 13:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264773AbUEJRpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 13:45:54 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:34300 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264761AbUEJRpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 13:45:52 -0400
Date: Mon, 10 May 2004 19:45:45 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Andreas Gruenbacher <agruen@suse.de>,
       Nathan Scott <nathans@sgi.com>
Subject: Re: [PATCH] 2.6.6 Have XFS use kernel-provided qsort
Message-ID: <20040510174545.GE7199@fs.tum.de>
References: <20040510050905.GB13889@taniwha.stupidest.org> <20040510125636.GJ9028@fs.tum.de> <20040510171512.GB12314@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040510171512.GB12314@taniwha.stupidest.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 10:15:12AM -0700, Chris Wedgwood wrote:
> On Mon, May 10, 2004 at 02:56:36PM +0200, Adrian Bunk wrote:
> 
> > This results in an empty file being left.
> 
> True, but it is/way mostly for illustrative purposes anyhow since XFS
> changes end up going in via ptools some futzing would be required
> anyhow.

It's not a big issue, but it's present in 2.6.6-mm1.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

