Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262511AbVCKEfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262511AbVCKEfW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 23:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVCKEfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 23:35:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:11993 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262736AbVCKEey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 23:34:54 -0500
Subject: Re: [PATCH] AGP support for powermac G5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@cyclades.com
Cc: Paul Mackerras <paulus@samba.org>, Linus Torvalds <torvalds@osdl.org>,
       Dave Jones <DaveJ@redhat.com>, Jerome Glisse <j.glisse@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@ozlabs.org>
In-Reply-To: <1110513167.3049.45.camel@desktop.cunningham.myip.net.au>
References: <16945.2617.625095.404994@cargo.ozlabs.ibm.com>
	 <1110513167.3049.45.camel@desktop.cunningham.myip.net.au>
Content-Type: text/plain
Date: Fri, 11 Mar 2005 15:29:02 +1100
Message-Id: <1110515343.32524.343.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> No power management support? :>

Heh, not yet :) We can't really put a G5 to sleep yet. I haven't figured
out the magic incantations for the PMU chip on those.

Ben.


