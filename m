Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUDEVvh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:51:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263315AbUDEVtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:49:18 -0400
Received: from pixpat.austin.ibm.com ([192.35.232.241]:47441 "EHLO
	zircon.austin.ibm.com") by vger.kernel.org with ESMTP
	id S263322AbUDEVsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:48:43 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Christian Kujau <evil@g-house.de>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: 2.6.5-pre* does not boot on my PReP PPC
Date: Mon, 5 Apr 2004 16:48:26 -0500
User-Agent: KMail/1.5.3
Cc: Sven Hartge <hartge@ds9.gnuu.de>, linux-kernel@vger.kernel.org,
       linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
References: <20040329151515.GD2895@smtp.west.cox.net> <20040405155022.GL31152@smtp.west.cox.net> <4071CD50.2000402@g-house.de>
In-Reply-To: <4071CD50.2000402@g-house.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200404051648.26220.hollisb@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 April 2004 16:19, Christian Kujau wrote:
> um, yes. but the target "common_defconfig" was disabled somewhere in
> 2.5, so my shini script broke. i wanted to do common_defconfig first,
> then always keep my .config and do "oldconfig" after patching, but
> somehow my script broke, so i went with "allnoconfig"...but ok, i'll try
> again.

FWIW, I use ibmchrp_config and then enable a couple PReP-specific things. It's 
pretty bare...

-- 
Hollis Blanchard
IBM Linux Technology Center

