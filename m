Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030477AbVKPX1X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030477AbVKPX1X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 18:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030546AbVKPX1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 18:27:23 -0500
Received: from cantor2.suse.de ([195.135.220.15]:23482 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030477AbVKPX1X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 18:27:23 -0500
Date: Thu, 17 Nov 2005 00:27:20 +0100
From: Olaf Hering <olh@suse.de>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
Subject: Re: [PATCH] ppc64: 64K pages support
Message-ID: <20051116232720.GA29512@suse.de>
References: <1130915220.20136.14.camel@gaston> <1130916198.20136.17.camel@gaston> <20051109172125.GA12861@lst.de> <20051109201720.GB5443@w-mikek2.ibm.com> <1131568336.24637.91.camel@gaston> <1131573556.25354.1.camel@localhost.localdomain> <1131573693.24637.109.camel@gaston> <1131574051.25354.3.camel@localhost.localdomain> <20051116230820.GA29068@suse.de> <1132183002.24066.90.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1132183002.24066.90.camel@localhost.localdomain>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Wed, Nov 16, Badari Pulavarty wrote:

> I think I am using SLES9. Planning to update to SP3.
> 
> # rpm -qi glibc | head
> Name        : glibc                        Relocations: (not
> relocatable)
> Version     : 2.3.3                             Vendor: SuSE Linux AG,
> Nuernberg, Germany
> Release     : 98.28                         Build Date: Wed Jun 30
> 15:55:45 2004

The release number indicates the GA glibc.spec was used, but the
build date indicates its slightly older than SLES9 GA.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
