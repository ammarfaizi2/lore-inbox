Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTLAEmV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 23:42:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263298AbTLAEmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 23:42:21 -0500
Received: from m17.lax.untd.com ([64.136.30.80]:47259 "HELO m17.lax.untd.com")
	by vger.kernel.org with SMTP id S263292AbTLAEmU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 23:42:20 -0500
To: wli@holomorphy.com
Cc: linux-kernel@vger.kernel.org
Date: Sun, 30 Nov 2003 18:06:41 -0800
Subject: Re: Oops with tmpfs on both 2.4.22 & 2.6.0-test11
Message-ID: <20031130.180800.-1591395.6.mcmechanjw@juno.com>
X-Mailer: Juno 5.0.33
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: James W McMechan <mcmechanjw@juno.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> No, it looks like the list poison fooled me.

It took staring at the list_del for me to notice also

> 
> I'm really not sure what the ->d_subdirs rearrangement is supposed
> to accomplish.

Neither am I, it needs a few comments

> No, I've gotten as far as I can with your oopsen. Either someone 
> else
> will have to pick it up from here or I'll have to spend more time
> looking at fs/libfs.c
> 
> 
> -- wli

Have you got a suggestion on who to bug, I have not found
maintainers on tmpfs or now the libfs section.

________________________________________________________________
The best thing to hit the internet in years - Juno SpeedBand!
Surf the web up to FIVE TIMES FASTER!
Only $14.95/ month - visit www.juno.com to sign up today!
