Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265086AbUHNUVU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265086AbUHNUVU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Aug 2004 16:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265134AbUHNUVU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Aug 2004 16:21:20 -0400
Received: from haw-66-102-130-200.vel.net ([66.102.130.200]:29864 "EHLO
	mail_103.selectedhosting.com") by vger.kernel.org with ESMTP
	id S265086AbUHNUUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Aug 2004 16:20:24 -0400
From: Udo Hoerhold <kernel-mail@goodontoast.com>
To: linux-kernel@vger.kernel.org
Subject: pthread stack size
Date: Sat, 14 Aug 2004 16:21:22 -0400
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200408141621.22630.kernel-mail@goodontoast.com>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm trying to install cedega (formerly winex), and it's complaining that my 
"pthread stack size", which is apparently 2052, is too small.  I'm running 
Mepis, but I'm using the vanilla 2.4.27 kernel.  Can anyone tell me if it's 
possible for me to recompile the kernel to increase the stack size?

Thanks,

Udo Hoerhold
