Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262361AbUCHAwb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 19:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262364AbUCHAwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 19:52:31 -0500
Received: from ce.fis.unam.mx ([132.248.33.1]:13730 "EHLO ce.fis.unam.mx")
	by vger.kernel.org with ESMTP id S262361AbUCHAw2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 19:52:28 -0500
From: Max Valdez <maxvalde@fis.unam.mx>
Organization: CCF
To: linux-kernel@vger.kernel.org
Subject: distcc crashes fedora 2.4.22-1.2149.nptl
Date: Sun, 7 Mar 2004 18:52:18 -0600
User-Agent: KMail/1.6.51
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403071852.18132.maxvalde@fis.unam.mx>
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

I'm experiencing something weird, I use distcc over a couple of boxes using 
fedora, both of them crash every once in a while if compiling something 
remotelly. But it seems to happen only when the sender is my box running 
2.6.4-rc1-mm1 kernel, not tried other 2.6 kernels, but with 2.4.25 nothing 
bad happened.

The fedora kernel version is 2.4.22-1.2149.nptl.

I know this is not the correct list to ask problems about fedora, but maybe 
someone knows what can be happening, and what can I do to trace the problem 
down. Should I try to install a vanilla kernel to see if that corrects the 
problem ?

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
