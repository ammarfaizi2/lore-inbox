Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVGYUck@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVGYUck (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVGYUcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:32:39 -0400
Received: from cfa.harvard.edu ([131.142.10.1]:54500 "EHLO cfa.harvard.edu")
	by vger.kernel.org with ESMTP id S261549AbVGYUb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:31:59 -0400
Date: Mon, 25 Jul 2005 16:31:56 -0400 (EDT)
From: Gaspar Bakos <gbakos@cfa.harvard.edu>
Reply-To: gbakos@cfa.harvard.edu
To: linux-kernel@vger.kernel.org
Subject: elvtune with 2.6 kernels (under FC3)
Message-ID: <Pine.SOL.4.58.0507251629130.2429@titan.cfa.harvard.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am cc-ing this to the kernel list, a i have the suspicion that it may
be a kernel related feature.

--------------
I noticed that elvtune does not work on FC3 with a 2.6.12.3
(self-compiled, pristine) kernel. I also tried it with other 2.6.* kernels.

elvtune /dev/sde
ioctl get: Invalid argument

In fact, I get the same message for all disks, either those on a 3ware
controller, or SATA disks directly attached to the motherboard.
The hw is a dual opteron mb with 4Gb RAM.

Did this command become obsoleted?
Is there alternativ?

Cheers
Gaspar
