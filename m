Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263126AbVCKEVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263126AbVCKEVQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:21:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbVCKESA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:18:00 -0500
Received: from 206.175.9.210.velocitynet.com.au ([210.9.175.206]:36784 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261152AbVCKEGj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:06:39 -0500
Subject: Re: [PATCH] AGP support for powermac G5
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Paul Mackerras <paulus@samba.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Dave Jones <DaveJ@redhat.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jerome Glisse <j.glisse@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev@ozlabs.org
In-Reply-To: <16945.6211.331369.393573@cargo.ozlabs.ibm.com>
References: <16945.2617.625095.404994@cargo.ozlabs.ibm.com>
	 <1110513167.3049.45.camel@desktop.cunningham.myip.net.au>
	 <16945.6211.331369.393573@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1110514099.3049.47.camel@desktop.cunningham.myip.net.au>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 11 Mar 2005 15:08:19 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-03-11 at 15:02, Paul Mackerras wrote:
> Nigel Cunningham writes:
> 
> > No power management support? :>
> 
> The suspend/resume methods are in the pci_driver struct, not the
> agp_bridge_driver struct.  Not that we have suspend/resume on the G5
> yet.

Ah. Thought I'd seen some in others.

Humble apologies.

Nigel
-- 
Nigel Cunningham
Software Engineer, Canberra, Australia
http://www.cyclades.com
Bus: +61 (2) 6291 9554; Hme: +61 (2) 6292 8028;  Mob: +61 (417) 100 574

Maintainer of Suspend2 Kernel Patches http://suspend2.net

