Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264730AbTGGGes (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 02:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266822AbTGGGes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 02:34:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43528 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S264730AbTGGGer (ORCPT
	<rfc822;linux-kernel@vger.redhat.com>);
	Mon, 7 Jul 2003 02:34:47 -0400
From: Russell Coker <russell@coker.com.au>
Reply-To: Russell Coker <russell@coker.com.au>
To: Linux Kernel <linux-kernel@vger.redhat.com>
Subject: cs46xx driver broken in 2.4.22-pre3
Date: Mon, 7 Jul 2003 16:49:05 +1000
User-Agent: KMail/1.5.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071649.05627.russell@coker.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In pre3 any attempt to rmmod the cs46xx driver results in a kernel panic.  In 
pre2 there was no problem.

I can provide ksymoops output on demand.

-- 
http://www.coker.com.au/selinux/   My NSA Security Enhanced Linux packages
http://www.coker.com.au/bonnie++/  Bonnie++ hard drive benchmark
http://www.coker.com.au/postal/    Postal SMTP/POP benchmark
http://www.coker.com.au/~russell/  My home page

