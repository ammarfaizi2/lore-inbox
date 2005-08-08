Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753155AbVHHApp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbVHHApp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 20:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753158AbVHHApp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 20:45:45 -0400
Received: from smtpout6.uol.com.br ([200.221.4.197]:40321 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S1753155AbVHHApo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 20:45:44 -0400
Date: Sun, 7 Aug 2005 21:45:37 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-rc5-mm1
Message-ID: <20050808004537.GA20109@ime.usp.br>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050807014214.45968af3.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andrew, for including the vfat speedup patch.

It has really improved a lot the performance of access to directories
having many subdirectories in an external Firewire HD that I have.

I'd say that if others don't have problems with it, then it should be
in 2.6.13, as far as I am concerned.

BTW, everything is working fine with the sbp2/ieee1394 drivers that
are in the mm tree.

It seems that there are some issues with ALSA, though. I will report
back as soon as I see if these are userland problems or not (it worked
fine with vanilla 2.6.13-rc5).


Thanks, Rogério.

-- 
Rogério Brito : rbrito@ime.usp.br : http://www.ime.usp.br/~rbrito
Homepage of the algorithms package : http://algorithms.berlios.de
Homepage on freshmeat:  http://freshmeat.net/projects/algorithms/
