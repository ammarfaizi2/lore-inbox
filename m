Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266859AbTAPRWt>; Thu, 16 Jan 2003 12:22:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267119AbTAPRWt>; Thu, 16 Jan 2003 12:22:49 -0500
Received: from buitenpost.surfnet.nl ([192.87.108.12]:58849 "EHLO
	buitenpost.surfnet.nl") by vger.kernel.org with ESMTP
	id <S266859AbTAPRWs>; Thu, 16 Jan 2003 12:22:48 -0500
Date: Thu, 16 Jan 2003 18:24:48 +0100
From: otter@kjoe.net
To: linux-kernel@vger.kernel.org
Subject: i830 DRM version
Message-ID: <20030116172448.GB1038@pangsit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: Mutt on Debian GNU/Linux sid
X-Editor: vim
X-Organisation: SURFnet bv
X-Address: Radboudburcht, P.O. Box 19035, 3501 DA Utrecht, NL
X-Phone: +31 302 305 305
X-Telefax: +31 302 305 329
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have installed a 4.2.99.3 XFree86 on my laptop and needed newer
i810/i830 DRM drivers to be able to get DRI working. Current version in
the 2.5.58 kernel is 1.2.1 and a version > 1.3 is needed.  I copied all
i8* files from the XFree86 CVS linux drm directory to drivers/char/drm
and this made DRI working again. 

Is an update of the kernel drivers foreseen so that it will work
seamlessly when XFree86 4.3 is published?


-- Niels
