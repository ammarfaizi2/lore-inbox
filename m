Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUCKT1Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 14:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbUCKT0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 14:26:47 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:9904 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S261670AbUCKT0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 14:26:17 -0500
From: Max Valdez <maxvalde@fis.unam.mx>
Organization: CCF
To: Sid Boyce <sboyce@blueyonder.co.uk>
Subject: Re: NVIDIA and 2.6.4?
Date: Thu, 11 Mar 2004 13:26:07 -0600
User-Agent: KMail/1.6.51
Cc: linux-kernel@vger.kernel.org
References: <405082A2.5040304@blueyonder.co.uk>
In-Reply-To: <405082A2.5040304@blueyonder.co.uk>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200403111326.08055.maxvalde@fis.unam.mx>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's weird:
uname -a
Linux garaged 2.6.4-rc2-mm1 #1 SMP Wed Mar 10 20:27:04 CST 2004 i686 Intel(R) 
Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux

$ lsmod | grep nv
nvidia               2075144  12


Running KDE, using kdm, with nvidia module, no problem, I notice a slight 
difference on fonts, but I dont know if it's my imagination.

Been using nvidia modules for quite a few 2.6.x kernels, most of them mmX. 
without problems

Max
-- 
Linux garaged 2.6.3-mm3 #2 SMP Tue Feb 24 15:44:58 CST 2004 i686 Intel(R) 
Pentium(R) 4 CPU 2.80GHz GenuineIntel GNU/Linux
-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GS/S d- s: a-29 C++(+++) ULAHI+++ P+ L++>+++ E--- W++ N* o-- K- w++++ O- M-- 
V-- PS+ PE Y-- PGP++ t- 5- X+ R tv++ b+ DI+++ D- G++ e++ h+ r+ z**
------END GEEK CODE BLOCK------
gpg-key: http://garaged.homeip.net/gpg-key.txt
