Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVBHT5W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVBHT5W (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 14:57:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbVBHT5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 14:57:22 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:61706 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261646AbVBHT5U
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 14:57:20 -0500
Message-Id: <200502082223.j18MMxs0013724@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: Blaisorblade <blaisorblade@yahoo.it>
cc: Anton Altaparmakov <aia21@cam.ac.uk>, lkml <linux-kernel@vger.kernel.org>,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [BUG report] UML linux-2.6 latest BK doesn't compile 
In-Reply-To: Your message of "Tue, 08 Feb 2005 18:37:22 +0100."
             <200502081837.22519.blaisorblade@yahoo.it> 
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200502081829.j18ITAs0003968@ccure.user-mode-linux.org>  <200502081837.22519.blaisorblade@yahoo.it> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Feb 2005 17:22:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blaisorblade@yahoo.it said:
> Why not simply disable CONFIG_GCOV for him, in this case? 

Anton presumably turned on CONFIG_GCOV because he wanted to do some profiling...

				Jeff

