Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261805AbVB1XCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261805AbVB1XCB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 18:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVB1XCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 18:02:00 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:18698 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261797AbVB1XB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 18:01:57 -0500
Date: Tue, 1 Mar 2005 00:01:55 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Christoph Hellwig <hch@infradead.org>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Mark_Salyzyn@adaptec.com
Subject: Re: [2.6 patch] SCSI: possible cleanups
Message-ID: <20050228230155.GV4021@stusta.de>
References: <20050228213159.GO4021@stusta.de> <20050228222509.GB19376@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050228222509.GB19376@infradead.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2005 at 10:25:09PM +0000, Christoph Hellwig wrote:
>...
> >   - constants.c: scsi_print_hostbyte
> >   - constants.c: scsi_print_driverbyte
> 
> these we'll probably keep for now.
>...

keep = #if 0 ?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

