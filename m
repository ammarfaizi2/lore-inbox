Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVCCUAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVCCUAN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 15:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVCCT40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 14:56:26 -0500
Received: from main.gmane.org ([80.91.229.2]:61665 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261961AbVCCTyQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 14:54:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Pasi Savolainen <psavo@iki.fi>
Subject: Re: [linux-usb-devel] [2.6 patch] remove drivers/usb/image/hpusbscsi.c
Date: Thu, 3 Mar 2005 19:48:06 +0000 (UTC)
Message-ID: <slrnd2eqp4.19r.psavo@varg.dyndns.org>
References: <20050303133856.GT4608@stusta.de> <200503031613.36758.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: a11a.mannikko1.ton.tut.fi
X-Face: $sk2zxhxVp'QPUj~kr+z:<m>#+84DO\Ab{4Hes1.P>]p=XhgsnwZM^[:"M?W#_x{W5[lu7i bqv7lOL`]5G%fH"Pgd5;+t"w)sOPDg::&T$Z9p#|xSMIb`$Udj6u14lh]imQ\z
User-Agent: slrn/0.9.8.1 (Debian)
X-Gmane-MailScanner: Found to be clean
Cc: linux-usb-devel@lists.sourceforge.net
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Oliver Neukum <oliver@neukum.org>:
> Am Donnerstag, 3. März 2005 14:38 schrieb Adrian Bunk:
>> USB_HPUSBSCSI was marked as BROKEN in 2.6.11 since libsane is the 
>> preferred way to access these devices.
>
> That is true only if you limit yourself to users of SANE.
> Other, rarer scan systems like VueScan use it. At least last time
> somebody mentioned them.

Vuescan uses libusb these days, didn't need hpusbscsi last time I used
it.
I don't know about other (program-) users.


-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>

