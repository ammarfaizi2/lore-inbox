Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261527AbVDGW2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbVDGW2K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 18:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262180AbVDGW2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 18:28:10 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:59656 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261527AbVDGW2G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 18:28:06 -0400
Date: Fri, 8 Apr 2005 00:28:05 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Jose =?iso-8859-1?Q?=C1ngel_De_Bustos_P=E9rez?= 
	<jadebustos@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A problem with kswapd
Message-ID: <20050407222805.GG4325@stusta.de>
References: <59ab6ac105040400423fefd96a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59ab6ac105040400423fefd96a@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 04, 2005 at 09:42:39AM +0200, Jose Ángel De Bustos Pérez wrote:
> Hi,
> 
> I have a problem with kswapd and I didn't find anything in the
> archives of the list (I hope not having missed someone).
> 
> kswapd is using 100% of CPU in a suse sles8 with kernel 2.4.241. This
> machine has its FS under LVM and ResiserFS, except for /boot which is
> in ext2.
> 
> Any idea? Thanks in advance.

If your kernel is a kernel that came with SuSE, please contact SuSE 
support.

If your kernel is a vanilla ftp.kernel.org kernel, please try whether 
2.4.30 already fixes this issue.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

