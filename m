Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTFAEnr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 00:43:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbTFAEnr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 00:43:47 -0400
Received: from BELLINI.MIT.EDU ([18.62.3.197]:61190 "EHLO bellini.mit.edu")
	by vger.kernel.org with ESMTP id S261245AbTFAEnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 00:43:45 -0400
Date: Sun, 1 Jun 2003 00:57:27 -0400 (EDT)
From: ghugh Song <ghugh@bellini.mit.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rmap 15j for 2.4.21-rc6
Message-ID: <Pine.LNX.4.53.0306010049500.6637@bellini.mit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Frank wrote:

>On a P4/533-2.4Ghz/512MB with udma5 IDE ~50MB/s:
>
>Shows severe interactivity problems and hangs
>
>Scroll and mouse hangs and delayed response to keyboard
>greater 1s are easily observable.
>
>Test script: tstinter V0.1

Unlike your case,
On a Athlon 2700+/166MHz DDR/1GB on a board having Nvidia2 chipset
with SCSI hard disks, it solved all my interactivity problem.
BTW, I do LaTeXing the most.  I have never tested such test
scripts.

More information about my case can be found in

http://www.ussg.iu.edu/hypermail/linux/kernel/0305.3/1894.html

Regards,

G. Hugh Song


