Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262599AbUJ0S26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262599AbUJ0S26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 14:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUJ0SYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 14:24:13 -0400
Received: from [129.105.5.125] ([129.105.5.125]:4346 "EHLO
	delta.ece.northwestern.edu") by vger.kernel.org with ESMTP
	id S262618AbUJ0SR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 14:17:58 -0400
Message-ID: <417FE6A8.5090803@ece.northwestern.edu>
Date: Wed, 27 Oct 2004 13:19:20 -0500
From: Lei Yang <lya755@ece.northwestern.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040921
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: set blksize of block device
X-Enigmail-Version: 0.76.8.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am learning block device drivers and have a newbie question. Given a 
block device, is there anyway that I could set its block size? For 
example, I want to write a block device driver that will work on an 
existing block device.  In this driver, I want block size smaller. (The 
idea looks confusing but I could explain if anybody is interested :- )  
However,  typically the block size is 1KB, now I want to set it to 512 
or 256.  Can I do it?

TIA
Lei

