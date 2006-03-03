Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751140AbWCCKxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751140AbWCCKxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Mar 2006 05:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751181AbWCCKxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Mar 2006 05:53:20 -0500
Received: from mx1.sonologic.nl ([82.94.245.21]:16073 "EHLO mx1.sonologic.nl")
	by vger.kernel.org with ESMTP id S1751140AbWCCKxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Mar 2006 05:53:19 -0500
Message-ID: <44082001.9090308@metro.cx>
Date: Fri, 03 Mar 2006 11:52:49 +0100
From: Koen Martens <linuxarm@metro.cx>
Organization: Sonologic
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-arm-kernel@lists.arm.linux.org.uk, ben@simtec.co.uk,
       linux-kernel@vger.kernel.org
Subject: [patch 0/14] s3c2412/s3c2413 support
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Helo-Milter-Authen: gmc@sonologic.nl, linuxarm@metro.cx, mx1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds various defines and bits for the s3c2412 and s3c2413
processors, as well as adding detection of this cpu to platform setup and
uncompress boot stage.
The changes should not disturb current s3c24xx implementations. The
patchset is preliminary, in that the final datasheet is not yet 
available. We
did some testing of these new registers and bits outside of the linux
kernel.

-- 
K.F.J. Martens, Sonologic, http://www.sonologic.nl/
Networking, hosting, embedded systems, unix, artificial intelligence.
Public PGP key: http://www.metro.cx/pubkey-gmc.asc
Wondering about the funny attachment your mail program
can't read? Visit http://www.openpgp.org/

