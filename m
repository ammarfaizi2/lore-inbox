Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbWF2UFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbWF2UFa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 16:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932386AbWF2UF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 16:05:29 -0400
Received: from static-ip-62-75-166-246.inaddr.intergenia.de ([62.75.166.246]:33164
	"EHLO bu3sch.de") by vger.kernel.org with ESMTP id S932382AbWF2UF2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 16:05:28 -0400
From: Michael Buesch <mb@bu3sch.de>
To: "John W. Linville" <linville@tuxdriver.com>
Subject: Re: [Ubuntu PATCH] Broadcom wireless patch, PCIE/Mactel support
Date: Thu, 29 Jun 2006 22:04:57 +0200
User-Agent: KMail/1.9.1
References: <44909A3F.4090905@oracle.com> <20060615133220.57d8dd26@localhost> <20060629195456.GG24463@tuxdriver.com>
In-Reply-To: <20060629195456.GG24463@tuxdriver.com>
Cc: Stefano Brivio <stefano.brivio@polimi.it>,
       Randy Dunlap <randy.dunlap@oracle.com>,
       lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>,
       mb@bu3sch.de, akpm <akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606292204.58103.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 29 June 2006 21:55, John W. Linville wrote:
> On Thu, Jun 15, 2006 at 01:32:20PM +0200, Stefano Brivio wrote:
> > On Wed, 14 Jun 2006 16:22:39 -0700
> > Randy Dunlap <randy.dunlap@oracle.com> wrote:
> > 
> > > From: Matthew Garrett <mjg59@srcf.ucam.org>
> > > 
> > > Broadcom wireless patch, PCIE/Mactel support
> > > 
> > > http://www.kernel.org/git/?p=linux/kernel/git/bcollins/ubuntu-dapper.git;a=commitdiff;h=1373a8487e911b5ee204f4422ddea00929c8a4cc
> > > 
> > > This patch adds support for PCIE cores to the bcm43xx driver. This is
> > > needed for wireless to work on the Intel imacs. I've submitted it to
> > > bcm43xx upstream.
> > 
> > NACK.
> > This has been superseded by my patchset:
> > http://www.mail-archive.com/bcm43xx-dev@lists.berlios.de/msg01267.html
> > 
> > I'm still waiting for more testing so I didn't request merging to mainline
> 
> Are these patches coming soon?

No, we don't have hardware to test it.

So if someone knows a PCIe Broadcom WLAN card... ;)

-- 
Greetings Michael.
