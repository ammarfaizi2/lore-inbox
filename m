Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbQL2CKn>; Thu, 28 Dec 2000 21:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129663AbQL2CKd>; Thu, 28 Dec 2000 21:10:33 -0500
Received: from host0.the-party.cybercity.dk ([62.66.128.2]:2315 "HELO
	fw.theparty.dk") by vger.kernel.org with SMTP id <S129370AbQL2CKS>;
	Thu, 28 Dec 2000 21:10:18 -0500
Date: Fri, 29 Dec 2000 02:40:25 +0100
From: Jens Axboe <axboe@suse.de>
To: "Udo A. Steinberg" <sorisor@Hell.WH8.TU-Dresden.De>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Oops when mounting cdrom
Message-ID: <20001229024025.A5327@suse.de>
In-Reply-To: <3A4BE117.3F58333B@Hell.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3A4BE117.3F58333B@Hell.WH8.TU-Dresden.De>; from sorisor@Hell.WH8.TU-Dresden.De on Fri, Dec 29, 2000 at 01:55:51AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29 2000, Udo A. Steinberg wrote:
> Hi all,
> 
> When mounting a 700 MB CD-RW in my Plextor CD-ROM, my machine
> reliably oopses. Below is the first oops decoded.
> 
> >>EIP; c01be6df <cdrom_log_sense+f/70>   <=====

Fixed in pre5

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
