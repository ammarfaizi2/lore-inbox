Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264681AbSJ3OU0>; Wed, 30 Oct 2002 09:20:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264682AbSJ3OU0>; Wed, 30 Oct 2002 09:20:26 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:59140 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S264681AbSJ3OUZ>; Wed, 30 Oct 2002 09:20:25 -0500
Date: Wed, 30 Oct 2002 09:26:12 -0500
From: Ben Collins <bcollins@debian.org>
To: Stelian Pop <stelian.pop@fr.alcove.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 2.5.bk] allow sbp2 driver to compile again
Message-ID: <20021030142611.GG1521@phunnypharm.org>
References: <20021030141338.GF17103@tahoe.alcove-fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021030141338.GF17103@tahoe.alcove-fr>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2002 at 03:13:38PM +0100, Stelian Pop wrote:
> Hi,
> 
> The attached patch is required to make the sbp2 compile again.
> 
> Note however that, until 2.5.45 is released, one should tweak 
> the Makefile to manually change the version in order to get
> the KERNEL_VERSION tests work...

You're going to need to diff this against our SVN tree, or wait till I
resync with 2.5.45. Seems it depends on patches in BK against our stock
source.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
