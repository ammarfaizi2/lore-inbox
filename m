Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131259AbRCMXSL>; Tue, 13 Mar 2001 18:18:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131260AbRCMXRv>; Tue, 13 Mar 2001 18:17:51 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:23556 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S131259AbRCMXRr>; Tue, 13 Mar 2001 18:17:47 -0500
Date: Tue, 13 Mar 2001 16:17:04 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac20
Message-ID: <20010313161704.A15082@mail.harddata.com>
In-Reply-To: <E14cgXm-0003O5-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <E14cgXm-0003O5-00@the-village.bc.nu>; from Alan Cox on Tue, Mar 13, 2001 at 04:36:18AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 13, 2001 at 04:36:18AM +0000, Alan Cox wrote:
...
> 
> 2.4.2-ac20
...
> o	Fix Alpha build					(Jeff Garzik)

Now I see (at least on Alpha) a constant wailing:

..../linux-2.4.2ac/include/linux/binfmts.h:45: warning: `struct 
mm_struct' declared inside parameter list
..../linux-2.4.2ac/include/linux/binfmts.h:45: warning: its scope is 
only this definition or declaration, which is probably not what you want

Is this somehow related?

   Michal
