Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129324AbRBYOlM>; Sun, 25 Feb 2001 09:41:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129313AbRBYOlD>; Sun, 25 Feb 2001 09:41:03 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:50507
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129305AbRBYOkv>; Sun, 25 Feb 2001 09:40:51 -0500
Date: Sun, 25 Feb 2001 15:40:43 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s/isa//g in drivers/scsi/g_NCR5380.c and some cleanup (242)
Message-ID: <20010225154043.D764@jaquet.dk>
In-Reply-To: <20010225151930.C764@jaquet.dk> <E14X2Fq-0003Ai-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E14X2Fq-0003Ai-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Feb 25, 2001 at 02:34:28PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Im running PIO. However while I agree with that one Im dubious about the
> inverts on the memcpy_*io bits
> 

I am sorry but have I inverted the arguments to the memcpy_*io calls?
Or are you referring to something other than the arguments here?
-- 
        Rasmus(rasmus@jaquet.dk)

"Science is like sex: sometimes something useful comes out, but that 
is not the reason we are doing it" -- Richard Feynman 
