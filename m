Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268083AbUHKPev@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268083AbUHKPev (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 11:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUHKPev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 11:34:51 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:29617 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S268083AbUHKPet
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 11:34:49 -0400
Subject: Re: OT: Distribution for Power4 Machines
From: Dave Hansen <haveblue@us.ibm.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: knobi@knobisoft.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15070000.1092237689@[10.10.2.4]>
References: <20040811055622.52917.qmail@web13911.mail.yahoo.com>
	 <15070000.1092237689@[10.10.2.4]>
Content-Type: text/plain
Message-Id: <1092238482.6033.4.camel@nighthawk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 11 Aug 2004 08:34:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-08-11 at 08:21, Martin J. Bligh wrote:
> >  sorry for the most likely off-topic post. Are there any distributions
> > out there that support IBM Power4 systems (pSeries machines)?
> 
> RH, SuSE and Debian all do, though maybe only the expensive enterprise
> versions of the former 2.

You can install Debian, it's just a bit of a pain.  You basically have
to replace the installer kernel with your own, and use the debian
root.bin floppy as your kernel initrd.  

http://lists.debian.org/debian-powerpc/2002/08/msg00458.html

-- Dave

