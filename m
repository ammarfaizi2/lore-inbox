Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbVCFJ6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbVCFJ6Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 04:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261348AbVCFJ6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 04:58:16 -0500
Received: from smtp2.dnainternet.net ([62.240.72.111]:29648 "EHLO
	smtp2.dnainternet.net") by vger.kernel.org with ESMTP
	id S261347AbVCFJ6N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 04:58:13 -0500
From: jarmo <oh1mrr@nic.fi>
To: linux-kernel@vger.kernel.org
Subject: ax25 t1_timeout
Date: Sun, 6 Mar 2005 11:58:11 +0200
User-Agent: KMail/1.7.2
Cc: ralf@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503061158.11446.oh1mrr@nic.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
Withs kernel 2.6.11 ax25 t1_timeout is working badly...
Expl. I have set t1_timeout to 10s (10000).Now testing..
Taking radio of,set connection to somewhere,first try then
10s time second try...But then 20s and try next 30s and try...
So t1_timeout is increasing?In 2.6.10 timeout is 10 and
it does not increase...Possible bug?

Jarmo
-- 
Linux is the answer.
What was your question?
(Brian Lane)
