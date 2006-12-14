Return-Path: <linux-kernel-owner+w=401wt.eu-S932883AbWLNRet@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932883AbWLNRet (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 12:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932885AbWLNRet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 12:34:49 -0500
Received: from smtp.bulldogdsl.com ([212.158.248.8]:2075 "EHLO
	mcr-smtp-002.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932883AbWLNRes (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 12:34:48 -0500
X-Greylist: delayed 1205 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 12:34:48 EST
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: libata-pata with ICH4, rootfs
Date: Thu, 14 Dec 2006 17:14:55 +0000
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612141714.55948.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,

Is it possible to use pata_mpiix (or pata_oldpiix) with an ICH4 IDE controller 
and boot off it?

I've tried compiling both drivers into the kernel, and totally disabling 
CONFIG_IDE, but it doesn't boot. dmesg doesn't indicate any detection has 
taken place. The old IDE layer works fine.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
