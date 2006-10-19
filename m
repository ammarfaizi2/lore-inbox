Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946104AbWJSPTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946104AbWJSPTS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Oct 2006 11:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161450AbWJSPTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Oct 2006 11:19:18 -0400
Received: from mail.dsa-ac.de ([62.112.80.99]:55313 "EHLO mail.dsa-ac.de")
	by vger.kernel.org with ESMTP id S1161451AbWJSPTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Oct 2006 11:19:17 -0400
Date: Thu, 19 Oct 2006 17:17:55 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 0/3] Clean up dead code for 2.6.18-rt6
Message-ID: <Pine.LNX.4.63.0610191640550.1920@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas, Ingo

In the following 3 email I am sending 3 patches, which remove code, that 
becomes unused with the rt-patch.

Compile-tested for ARM (which has undergone most changes) (mainstone and 
assabet configs) and i386 (defconfig and allmodconfig). Don't 
have a possibility to compile it for other platforms (at least here at 
work).

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany
