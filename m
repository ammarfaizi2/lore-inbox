Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263389AbTDYJq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 05:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTDYJq1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 05:46:27 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:50705 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S263389AbTDYJq0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 05:46:26 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aha1740 update
References: <wrpk7dkt84r.fsf@hina.wild-wind.fr.eu.org>
	<1051210184.4005.12.camel@dhcp22.swansea.linux.org.uk>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 25 Apr 2003 11:56:50 +0200
Message-ID: <wrpptnasxwd.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <1051210184.4005.12.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

Alan> The AHA1740 has firmware handled abort/reset handling. The "head
Alan> in sand" kernel code is correct for once 8)

That's nice ! :-) Is there any way to stop the kernel from screaming
each time the module loads ? Would defining a dummy abort handler
work ?

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
