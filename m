Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932201AbWDRLrr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932201AbWDRLrr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbWDRLrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:47:47 -0400
Received: from rubis.org ([82.230.33.161]:60104 "EHLO rubis.org")
	by vger.kernel.org with ESMTP id S932201AbWDRLrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:47:47 -0400
Message-ID: <4444D1D5.6070903@rubis.org>
Date: Tue, 18 Apr 2006 13:47:33 +0200
From: =?ISO-8859-15?Q?St=E9phane_Jourdois?= <kwisatz-lkml@rubis.org>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Adam Radford <linuxraid@amcc.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: 3w-9xxx status in kernel
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a question about 3w-9xxx driver versions :

3w-9xxx version in vanilla 2.6.16 is 2.26.02.005
3w-9xxx version in 2.6.17-rc1-mm2 is 2.26.02.006

but :
3w-9xxx version in 3ware.com 9.3.0.3 codebase is 2.26.04.007


The documentation with 9.3.0.3 codebase says it will not works with
kernel driver <2.26.04.004. But I observe it works fine with codebase
9.3.0.2 (the documentation says it should not).

What is current status of 3w-9xxx driver in 2.6 ?
Will it works on a 9550SX using 9.3.0.3 firmware ?
Could you update documentation about that somewhere, for exemple in
3w-9xxx.c header ?

Thanks very much.

-- 
 ///  Stephane Jourdois     /"\  ASCII RIBBON CAMPAIGN \\\
(((    Consultant securite  \ /    AGAINST HTML MAIL    )))
 \\\   24 rue Cauchy         X                         ///
  \\\  75015  Paris         / \    +33 6 8643 3085    ///
