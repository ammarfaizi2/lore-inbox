Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161051AbWHJGIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161051AbWHJGIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 02:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161054AbWHJGIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 02:08:21 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:50128 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1161051AbWHJGIV (ORCPT
	<rfc822;Linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 02:08:21 -0400
Message-ID: <44DACD51.7080607@garzik.org>
Date: Thu, 10 Aug 2006 02:08:17 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: keith.packard@intel.com
CC: Linux-kernel@vger.kernel.org, Dirk Hohndel <dirk.hohndel@intel.com>,
       Imad Sousou <imad.sousou@intel.com>
Subject: Re: Announcing free software graphics drivers for Intel i965 chipset
References: <1155151903.11104.112.camel@neko.keithp.com>
In-Reply-To: <1155151903.11104.112.camel@neko.keithp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Packard wrote:
> The Intel Open Source Technology Center graphics team is pleased to announce
> the immediate availability of free software drivers for the Intel® 965
> Express Chipset family graphics controller. These drivers include support
> for 2D and 3D graphics features for the newest generation Intel graphics
> architecture. The project Web site is http://IntelLinuxGraphics.org.

Very cool, and I definitely applaud Intel for supporting open source 
here.  A couple questions...

* is the 3D stuff available from git somewhere?  The download filename 
includes "-git-", but the checkout instructions reference cvs.

* is anyone working on a more dynamic GLSL compilation system?  i.e. a 
"JIT", in compiler technology terms.

Thanks,

	Jeff



