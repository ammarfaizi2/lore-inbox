Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263281AbTJVJ2A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 05:28:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbTJVJ2A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 05:28:00 -0400
Received: from atcmail.atc.tcs.co.in ([203.199.176.98]:56838 "EHLO
	atcmail.atc.tcs.co.in") by vger.kernel.org with ESMTP
	id S263281AbTJVJ17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 05:27:59 -0400
Subject: [REPOST] The Linux Progress Patch for 2.6 Kernels
From: Prasad <prasad@atc.tcs.co.in>
Reply-To: Prasad <prasad@atc.tcs.co.in>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Tata Consultancy Services
Message-Id: <1066815305.2340.27.camel@Prasad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 22 Oct 2003 15:05:05 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello everyone,
        For people who might be interested in having a
boot screen for linux or those interested in the linux
progress patch for the 2.6 kernels.  I have one that 
works fine with x86. I have not tested on the other 
platforms but it should work fine. It has been completely 
rewritten to suite the changed frame buffer code in 2.6 and
has been renamed to ELPP, the enhanced linux progress patch.


It can be downloaded from 
        http://students.iiit.net/~prasad_s/lpp/


The features include...
o Showing customizable number of messages at a time
o The success/failure/warning status of the scripts
   Just tryout the theme that comes by default!

The patch was made against 2.6.0-Test5 but should
perfectly work for the recent ones too.

Comments/Suggestions are welcome.

Prasad

-- 
Failure is not an Option

