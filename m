Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262666AbVGMOez@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262666AbVGMOez (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 10:34:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262668AbVGMOez
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 10:34:55 -0400
Received: from fbxmetz.linbox.com ([81.56.128.63]:60615 "EHLO xiii.metz")
	by vger.kernel.org with ESMTP id S262666AbVGMOey (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 10:34:54 -0400
Message-ID: <42D5268B.7050108@linbox.com>
Date: Wed, 13 Jul 2005 16:34:51 +0200
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.12: yukon2 nics still not supported...
References: <Pine.LNX.4.44.0307211749400.6905-100000@phoenix.infradead.org> <3F378FC3.1020507@freealter.com>
In-Reply-To: <3F378FC3.1020507@freealter.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

I recently had to boot a brand new system using a Marvel Yukon2 NIC (sk98lin) 
driver which is not supported by the latest kernel (pci ids = 11ab:4361).

So I compiled the GPLed driver available from Syskonnect, 
http://www.syskonnect.com/syskonnect/support/driver/d0102_driver.html, which 
works perfectly.

So, I wonder why the sk98lin driver is not up to date in the 2.6.x kernels ?

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
www.linbox.com www.linbox.org
