Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTAaTjQ>; Fri, 31 Jan 2003 14:39:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTAaTjQ>; Fri, 31 Jan 2003 14:39:16 -0500
Received: from havoc.daloft.com ([64.213.145.173]:14564 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S261963AbTAaTjQ>;
	Fri, 31 Jan 2003 14:39:16 -0500
Date: Fri, 31 Jan 2003 14:48:37 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
       Konrad Eisele <eiselekd@web.de>
Subject: Re: Perl in the toolchain
Message-ID: <20030131194837.GC8298@gtf.org>
References: <20030131133929.A8992@devserv.devel.redhat.com> <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301311327480.16486-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2003 at 01:41:26PM -0600, Kai Germaschewski wrote:
> Generally, we've been trying to not make perl a prequisite for the kernel 
> build, and I'd like to keep it that way. Except for some arch specific 

That's pretty much out the window when klibc gets merged, so perl will
indeed be a build requirement for all platforms...

	Jeff



