Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278077AbRJPD0w>; Mon, 15 Oct 2001 23:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278076AbRJPD0q>; Mon, 15 Oct 2001 23:26:46 -0400
Received: from codepoet.org ([166.70.14.212]:8556 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S278077AbRJPD0V>;
	Mon, 15 Oct 2001 23:26:21 -0400
Date: Mon, 15 Oct 2001 21:26:56 -0600
From: Erik Andersen <andersen@codepoet.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jc <jcb@jcb.yi.org>, linux-kernel@vger.kernel.org
Subject: Re: APM driver thoughts
Message-ID: <20011015212656.A32274@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, jc <jcb@jcb.yi.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011016011352.A10744@athena> <E15tHSK-0003pA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15tHSK-0003pA-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.9-ac18-rmk1, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Oct 16, 2001 at 12:47:36AM +0100, Alan Cox wrote:
> > well ..
> > since 2.4.10 , apm -s (suspend) does not work on dell c600
> > what was changed ?
> 
> Should be fixed in 2.4.12-ac

apm suspend suspends but will not resume on my 
Dell Latitude C800 under 2.4.12-ac2 or any 
other 2.4.x kernel I've tried.  Latest bios
is installed (A17), grub is in the MBR,

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
