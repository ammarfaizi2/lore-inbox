Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbTKMBza (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 20:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261892AbTKMBza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 20:55:30 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:54031 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S261891AbTKMBz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 20:55:29 -0500
Message-ID: <3FB2E490.2070503@dcrdev.demon.co.uk>
Date: Thu, 13 Nov 2003 01:55:28 +0000
From: Dan Creswell <dan@dcrdev.demon.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: PS/2 Mouse problems on 2.6-test9]
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, sent this to Andrew earlier........

Hi Andrew,

I'm not sure who best to send this report to so feedback appreciated.

I'm running kernel 2.6-test9 here on top of Fedora Core.

XFree boots just fine but a small amount of "torturing" with mouse
movement is sufficient to lock things up solid.

This kernel is compiled for SMP (I have two Xeon's with HyperThreading).

Re-compiling the kernel for single-processor usage results in a stable
system (I'm using it to write this email).

I'm using an Intellimouse PS/2 and the Xeon's are at 2.66Ghz.

More data points:

(1) I've not encountered this problem on a dual Athlon 1.8Ghz using the
same mouse and kernel 2.6-test9 (SMP or UP).

(2) The Fedora Core Kernel 2.4 compiled for SMP also runs stably on the
dual Xeon platform (I'm booted into that kernel now as I write this email).

What would you suggest as my next steps? Would you like some more
information/other tests performed?

Many thanks,

Dan.





