Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266310AbUAIAoH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266312AbUAIAoH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:44:07 -0500
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:40326 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S266310AbUAIAoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:44:05 -0500
Subject: Re: [Dri-devel] 2.4.23: user/kernel pointer bugs
	(drivers/char/vt.c, drivers/char/drm/gamma_dma.c)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Eric Anholt <eta@lclark.edu>
Cc: "Robert T. Johnson" <rtjohnso@eecs.berkeley.edu>,
       marcelo.tosatti@cyclades.com, faith@valinux.com,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1073608790.713.13.camel@leguin>
References: <1073592494.18588.77.camel@dooby.cs.berkeley.edu>
	 <1073605921.13007.68.camel@dhcp23.swansea.linux.org.uk>
	 <1073608790.713.13.camel@leguin>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1073608697.13107.0.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 09 Jan 2004 00:38:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-01-09 at 00:39, Eric Anholt wrote:
> Uhoh, the SiS is my fault.  I'll take a look soon.

Thats ok - I found it because I screwed up textures on your sis6326 code
8)


