Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbTIORHd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 13:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261579AbTIORHd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 13:07:33 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:1749 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261574AbTIORHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 13:07:31 -0400
Date: Mon, 15 Sep 2003 19:07:25 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: John Bradford <john@grabjohn.com>
Cc: neuffer@neuffer.info, linux-kernel@vger.kernel.org
Subject: Re: [1/4] [2.6 patch] better i386 CPU selection
Message-ID: <20030915170724.GN126@fs.tum.de>
References: <200309150745.h8F7jmbG000739@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309150745.h8F7jmbG000739@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 15, 2003 at 08:45:48AM +0100, John Bradford wrote:
> 
> I don't think we need verbose help texts anymore with the new
> selection scheme, but background info describing various workarounds
> would be a useful addition to /Documentation.

All the information is in arch/i386/Kconfig.

If it's needed a comment before the according option there might be 
helpful (but e.g. X86_F00F_BUG is very self-explaining).

> John.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

