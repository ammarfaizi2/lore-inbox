Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261857AbTDHPrZ (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261860AbTDHPrZ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:47:25 -0400
Received: from smtp.bitmover.com ([192.132.92.12]:56980 "EHLO
	smtp.bitmover.com") by vger.kernel.org with ESMTP id S261857AbTDHPrY (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 11:47:24 -0400
Date: Tue, 8 Apr 2003 08:58:58 -0700
From: Larry McVoy <lm@bitmover.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5 io statistics?
Message-ID: <20030408155858.GB27912@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a writeup of the changes anywhere?  I'd like to port cstat to 2.5.
Cstat is sort of a netstat/vmstat combo:

load free cach swap pgin  pgou dk0 dk1 dk2 dk3 ipkt opkt  int  ctx  usr sys idl
0.00  19M 562M  48M 4.0K   12K   0   0   0   0  137   25  267   83    0   0 100
0.00  18M 563M  48M   0    12K   0   0   0   0  133   22  258   77    0   1  99

-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
