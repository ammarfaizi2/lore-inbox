Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbULNAUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbULNAUZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 19:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbULNAUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 19:20:25 -0500
Received: from 82-43-72-5.cable.ubr06.croy.blueyonder.co.uk ([82.43.72.5]:61943
	"EHLO home.chandlerfamily.org.uk") by vger.kernel.org with ESMTP
	id S261356AbULNAUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 19:20:19 -0500
From: Alan Chandler <alan@chandlerfamily.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problem revisited - more brainpower needed
Date: Tue, 14 Dec 2004 00:20:17 +0000
User-Agent: KMail/1.7.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jens Axboe <axboe@suse.de>
References: <200411201842.15091.alan@chandlerfamily.org.uk> <1102851547.1371.17.camel@localhost.localdomain> <200412121334.55460.alan@chandlerfamily.org.uk>
In-Reply-To: <200412121334.55460.alan@chandlerfamily.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200412140020.18114.alan@chandlerfamily.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 12 December 2004 13:34, Alan Chandler wrote:
> On Sunday 12 December 2004 11:39, Alan Cox wrote:
> > Thanks ok so it moves with the drive. I'm beginning to wonder if it is
> > just a dud drive.
>
> I do too and am almost ready to throw in the towel (and I seem to be almost
> unique in experiencing these problems) - except

Towel now thrown.

...

> and
> linux 2.4 (using the ide-scsi module) the drive works perfectly.

Drive is obviously degrading, I tried it "one more time" today with 2.4, and 
it only just managed to work.  It managed to finish the task, but there were 
several resets and error messages very similar to the ones in 2.6.

My apologies to others time that I might have wasted, although it personally 
was a good learning experience on how the kernel works.
-- 
Alan Chandler
alan@chandlerfamily.org.uk
First they ignore you, then they laugh at you,
 then they fight you, then you win. --Gandhi
