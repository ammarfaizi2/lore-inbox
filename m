Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUIVTGP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUIVTGP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 15:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUIVTGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 15:06:15 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:29652 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S266669AbUIVTGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 15:06:13 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Date: Wed, 22 Sep 2004 21:06:50 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: NOT FIXED (Is anyone using vmware 4.5 with 2.6.9-rc2-mm
Cc: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <4506E4E6490@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Sep 04 at 0:16, Norberto Bensa wrote:
> Norberto Bensa wrote:
> > It's working now. I had this in fstab:
> 
> No, it's not working. After a reboot, same config, same kernel, same mounts, 
> same everything -> No vmware.
> 
> Just to summarize. 
> 
> * vmware with 2.6.9-rc1-mm5 works.
> * vmware with 2.6.9-rc2-mm1 doesn't work.
> 
> I'll try 2.6.9-rc2 if anyone wants but since not many people answered my 
> messages I guess there's no interest in vmware at all.

You said that you are putting large VMware temporary files on tmpfs,
and it is where my interest ends...

If you can provide strace of failed run, I can look at it.  
                                                    Best regards,
                                                        Petr Vandrovec

