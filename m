Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261354AbVAMS6D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261354AbVAMS6D (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 13:58:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261272AbVAMSy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 13:54:57 -0500
Received: from smtp003.mail.ukl.yahoo.com ([217.12.11.34]:8810 "HELO
	smtp003.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261307AbVAMSyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 13:54:05 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 8/8] uml: depend on !USERMODE in drivers/block/Kconfig and drop arch/um/Kconfig_block
Date: Thu, 13 Jan 2005 19:56:22 +0100
User-Agent: KMail/1.7.1
Cc: Jeff Dike <jdike@addtoit.com>, blaisorblade_spam@yahoo.it, akpm@osdl.org,
       linux-kernel@vger.kernel.org
References: <20050113051341.DD29D6325A@zion> <200501131827.j0DIRiha004079@ccure.user-mode-linux.org>
In-Reply-To: <200501131827.j0DIRiha004079@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501131956.22703.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 January 2005 19:27, Jeff Dike wrote:
> I'd prefer that USERMODE be changed to UML.
Ok, what you'd like is an additional patch however, because CONFIG_USERMODE 
has existed for ages, so for now this can go in, right?

The additional patch will be more or less a global "search and replace" 
USERMODE -> UML.

It's ok, I'll do it on top of these patches I sent.

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade
