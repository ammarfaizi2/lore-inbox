Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268365AbUI2NDD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268365AbUI2NDD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268367AbUI2NDD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:03:03 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:57993 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268365AbUI2NC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:02:59 -0400
Subject: Re: New DRM driver model - gets rid of DRM() macros!
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jon Smirl <jonsmirl@gmail.com>,
       DRI Devel <dri-devel@lists.sourceforge.net>,
       Xserver development <xorg@freedesktop.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040929133759.A11891@infradead.org>
References: <9e4733910409280854651581e2@mail.gmail.com>
	 <20040929133759.A11891@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096459192.15905.0.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 29 Sep 2004 12:59:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2004-09-29 at 13:37, Christoph Hellwig wrote:
>  - once we have Alan's idea of the graphics core implemented drm_init()
>    should go awaw

Last I heard Dave Airlie had that working having fixed my bugs.


