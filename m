Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261700AbUKOUpu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261700AbUKOUpu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:45:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbUKOUpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:45:38 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:32261 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S261693AbUKOUn7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:43:59 -0500
Message-ID: <419914F9.7050509@techsource.com>
Date: Mon, 15 Nov 2004 15:43:37 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Intel Corp. 82801BA/BAM not supported by ALSA?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I do 'lspci | grep -i audio', I get this:

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97 
Audio (rev 04)

Unfortunately, every effort has failed to get the slightest peep out.  I 
have tried following the instructions on the Gentoo site (with my own 
guesses about what to do differently for 2.6 kernels), but I don't get 
any sound.  Also, the "alsaconf" utility says it doesn't find any audio 
devices.

Can anyone help me with this?

Thanks!
