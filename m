Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUD1OUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUD1OUE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 10:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264822AbUD1OUE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 10:20:04 -0400
Received: from everest.2mbit.com ([24.123.221.2]:54754 "EHLO mail.sosdg.org")
	by vger.kernel.org with ESMTP id S264821AbUD1OTv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 10:19:51 -0400
Message-ID: <408FBD68.4090002@greatcn.org>
Date: Wed, 28 Apr 2004 22:19:20 +0800
From: Coywolf Qi Hunt <coywolf@greatcn.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel <linux-kernel@vger.kernel.org>
CC: akpm@osdl.org, rddunlap@osdl.org
X-Scan-Signature: 12165b451e859f13a791ef2235c53444
X-SA-Exim-Connect-IP: 218.24.185.115
X-SA-Exim-Mail-From: coywolf@greatcn.org
Subject: [PATCH] Update KT link in SubmittingDrivers and kernel-docs.txt
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Report: * -4.9 BAYES_00 BODY: Bayesian spam probability is 0 to 1%
	*      [score: 0.0000]
X-SA-Exim-Version: 4.0 (built Tue, 16 Mar 2004 14:56:42 -0500)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This update the kerneltraffic url link found in 
Documentation/SubmittingDrivers and Documentation/kernel-docs.txt.

    -- coywolf

==========================================================================================
diff -ur linux-2.6.5/Documentation/SubmittingDrivers 
linux/Documentation/SubmittingDrivers
--- linux-2.6.5/Documentation/SubmittingDrivers    Mon Mar  8 10:31:40 2004
+++ linux/Documentation/SubmittingDrivers    Wed Apr 28 21:45:34 2004
@@ -119,7 +119,7 @@
 
 Kernel traffic:
     Weekly summary of kernel list activity (much easier to read)
-    [http://kt.zork.net/kernel-traffic]
+    http://www.kerneltraffic.org/kernel-traffic/
 
 Linux USB project:
     http://sourceforge.net/projects/linux-usb/
diff -ur linux-2.6.5/Documentation/kernel-docs.txt 
linux/Documentation/kernel-docs.txt
--- linux-2.6.5/Documentation/kernel-docs.txt    Wed Feb 18 11:58:33 2004
+++ linux/Documentation/kernel-docs.txt    Wed Apr 28 22:04:43 2004
@@ -694,7 +694,7 @@
        produced during the week. Published every Thursday.
       
      * Name: "Kernel Traffic"
-       URL: http://kt.zork.net/kernel-traffic/
+       URL: http://www.kerneltraffic.org/kernel-traffic/
        Keywords: linux-kernel mailing list, weekly kernel news.
        Description: Weekly newsletter covering the most relevant
        discussions of the linux-kernel mailing list.

-- 
Coywolf Qi Hunt
Admin of http://GreatCN.org and http://LoveCN.org

