Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbTIRBI1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 21:08:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbTIRBI1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 21:08:27 -0400
Received: from imo-d01.mx.aol.com ([205.188.157.33]:65254 "EHLO
	imo-d01.mx.aol.com") by vger.kernel.org with ESMTP id S262921AbTIRBI0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 21:08:26 -0400
Date: Wed, 17 Sep 2003 21:07:42 -0400
From: bee71e@netscape.net
To: linux-kernel@vger.kernel.org
Subject: excessive swapping in 2.4.x
MIME-Version: 1.0
Message-ID: <7E768FF1.7BC13987.0005DAE9@netscape.net>
X-Mailer: Atlas Mailer 2.0
X-AOL-IP: 209.131.38.143
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

I am using 2.4.21 and I see an unusually large amount of swapping for relatively low load : 

sample vmstat output: (note that the system is almost idle)

  procs                      memory    swap          io     system         cpu
r  b  w   swpd   free   buff  cache  si  so    bi    bo   in    cs  us  sy  id
0  2  0 1850220  10524   9412 703652 3030 1102  3912  1106 1506  1710   1   1  98
0  2  0 1849188  10572   9388 700568 2780 376  3558   379 1434  1284   1   1  99
0  5  0 1851576  11668   9404 698228 2999 479  3890   488 1499  1487   1   1  98

Is this a known issue? Whats happening? How do I fix this?

thanks! 


__________________________________________________________________
McAfee VirusScan Online from the Netscape Network.
Comprehensive protection for your entire computer. Get your free trial today!
http://channels.netscape.com/ns/computing/mcafee/index.jsp?promo=393397

Get AOL Instant Messenger 5.1 free of charge.  Download Now!
http://aim.aol.com/aimnew/Aim/register.adp?promo=380455
