Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264516AbTFAABw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 20:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264523AbTFAABv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 20:01:51 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:57057
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S264516AbTFAABv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 20:01:51 -0400
Subject: Re: 2.4.21rc6-ac1 Nforce2 AGP+ATI FireGL v2.9.12=hard lock
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Gutko <gutko@poczta.onet.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3ED8E682.5020506@poczta.onet.pl>
References: <3ED8E682.5020506@poczta.onet.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054423040.28853.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jun 2003 00:17:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-05-31 at 18:29, Gutko wrote:
> During install of this rpm i get something like this:
> "Patching drmP.h  FAILED, saving rejects to....."
> This *.rej file is in attachment.
> Then module loads normally. I can start X on this driver, but only in 2d.
> Trying to run Tuxracer and any other 3d game hardlocks my machine. 2d 
> games works ok.

If it patches the kernel then I wouldnt be suprised if the patches are
not compatible


