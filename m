Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130941AbRCMHPM>; Tue, 13 Mar 2001 02:15:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130970AbRCMHOw>; Tue, 13 Mar 2001 02:14:52 -0500
Received: from mail.uni-kl.de ([131.246.137.52]:31617 "EHLO mail.uni-kl.de")
	by vger.kernel.org with ESMTP id <S130969AbRCMHOs>;
	Tue, 13 Mar 2001 02:14:48 -0500
Message-ID: <XFMail.20010313081421.backes@rhrk.uni-kl.de>
X-Mailer: XFMail 1.4.4 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
Date: Tue, 13 Mar 2001 08:14:21 +0100 (CET)
Reply-To: Joachim Backes <backes@rhrk.uni-kl.de>
Organization: University of Kaiserslautern,
 Computer Center [Supercomputing division]
From: Joachim Backes <backes@rhrk.uni-kl.de>
To: LINUX Kernel <linux-kernel@vger.kernel.org>
Subject: patch-2.4.2-ac19
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after applying patch-2.4.2-ac19 to the base 2.4.2 distribution, I have problems
to install vmware: the vmware install has problems to find the symbol

                skb_datarefp

in the /usr/src/linux/include tree.

Without applying patch-2.4.2-ac19, it is found in

                /usr/src/linux/include/linux/skbuff.h

and vmware-2.0.3-799 can be compiled.

Regards

Joachim Backes

--

Joachim Backes <backes@rhrk.uni-kl.de>       | Univ. of Kaiserslautern
Computer Center, Supercomputing Division     | Phone: +49-631-205-2438 
D-67653 Kaiserslautern, PO Box 3049, Germany | Fax:   +49-631-205-3056 
---------------------------------------------+------------------------
WWW: http://hlrwm.rhrk.uni-kl.de/home/staff/backes.html  

