Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVCaLkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVCaLkf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261384AbVCaLke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:40:34 -0500
Received: from aun.it.uu.se ([130.238.12.36]:42426 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261368AbVCaLkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:40:20 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16971.57746.578503.931803@alkaid.it.uu.se>
Date: Thu, 31 Mar 2005 13:40:02 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Paul Jackson <pj@engr.sgi.com>
Cc: Robert Hancock <hancockr@shaw.ca>, linux-kernel@vger.kernel.org
Subject: Re: AMD64 Machine hardlocks when using memset
In-Reply-To: <20050330234133.59fdafdf.pj@engr.sgi.com>
References: <3NTHD-8ih-1@gated-at.bofh.it>
	<424B7ECD.6040905@shaw.ca>
	<20050330234133.59fdafdf.pj@engr.sgi.com>
X-Mailer: VM 7.17 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson writes:
 > Yup - kills my x86_64 too.  I can't stay up for half a minute.
...
 > My mainboard is an MSI K8N Neo2 Platinum.

I've tested both versions of the test program on two Athlon64 boxes,
and neither has had any problems with them.

My two machines are both VIA K8T800-based (a desktop and a laptop),
but it seems those of you who had problems have nForce-based machines.
So presumably it's either the nForce chipset or your memory timings are
out of spec.

/Mikael
