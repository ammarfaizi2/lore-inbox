Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318076AbSHUIw5>; Wed, 21 Aug 2002 04:52:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSHUIw5>; Wed, 21 Aug 2002 04:52:57 -0400
Received: from mailserver1.hrz.tu-darmstadt.de ([130.83.126.41]:64520 "EHLO
	mailserver1.hrz.tu-darmstadt.de") by vger.kernel.org with ESMTP
	id <S318076AbSHUIw4>; Wed, 21 Aug 2002 04:52:56 -0400
Message-ID: <3D6355C5.6A51E11E@hrzpub.tu-darmstadt.de>
Date: Wed, 21 Aug 2002 10:56:37 +0200
From: Jens Wiesecke <j_wiese@hrzpub.tu-darmstadt.de>
X-Mailer: Mozilla 4.75 [de] (Windows NT 5.0; U)
X-Accept-Language: de
MIME-Version: 1.0
To: Rohan Deshpande <rohan@myeastern.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: P4 with i845E not booting with 2.4.19 / 3.5.31
References: <3D6245DC.3A189656@hrzpub.tu-darmstadt.de> <3D62482D.4030500@myeastern.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohan Deshpande wrote:

> hi there,
> 
> something to the same extent happened to me, with my P4, as ACPI caused
> a kernel panic.  if you have acpi enabled, try disabling it.

Unfortunately I already have ACPI, APIC and SMP disabled and cannot boot
the 2.4 kernels - I tried RedHat's LIMBO beta boot disk and I couldn't
boot either. It seems that the problem occurs at a very early stage at
boot.

Can anybody tell me if there is a possibility to further debug my boot
problem, for example enabling  more verbose boot messages ?

Best regards
-- 
Jens Wiesecke
Institute for Makromolecular Chemistry

e-mail: j_wiese@hrzpub.tu-darmstadt.de
