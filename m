Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263695AbVBCSGH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbVBCSGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 13:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263661AbVBCSFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 13:05:33 -0500
Received: from mrqout2.tiscali.it ([195.130.225.12]:484 "EHLO
	mrq-2.tiscalinet.it") by vger.kernel.org with ESMTP id S263690AbVBCSCG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 13:02:06 -0500
Date: Thu, 3 Feb 2005 18:59:34 +0100
Message-ID: <41DE936000008A70@mail-4-bnl.tiscali.it>
In-Reply-To: <20050203172844.GC3121@stusta.de>
From: "Joel Soete" <soete.joel@tiscali.be>
Subject: Re: NFSD needs EXPORTFS
To: "Adrian Bunk" <bunk@stusta.de>, "Matthew Wilcox" <matthew@wil.cx>,
       "Roman Zippel" <zippel@linux-m68k.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Christoph Hellwig" <hch@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

...
> 
> If the problem occured with CONFIG_XFS_FS=m I understand what went 
> wrong.
> 
Yes, it was

> It seems to be correct.
> 
> This was a side effect of Roman's fix for the XFS <-> EXPORTFS 
> dependency.
> 
Thanks a lot,
    Joel


