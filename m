Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129184AbRBXLBj>; Sat, 24 Feb 2001 06:01:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129222AbRBXLB3>; Sat, 24 Feb 2001 06:01:29 -0500
Received: from oxmail2.ox.ac.uk ([163.1.2.1]:32431 "EHLO oxmail.ox.ac.uk")
	by vger.kernel.org with ESMTP id <S129184AbRBXLBW>;
	Sat, 24 Feb 2001 06:01:22 -0500
Message-ID: <3A9794A9.5627E6A4@computing-services.oxford.ac.uk>
Date: Sat, 24 Feb 2001 11:02:01 +0000
From: A E Lawrence <adrian.lawrence@computing-services.oxford.ac.uk>
Organization: Not much
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: ian@wehrman.com, mhaque@haque.net, adilger@turbolinux.com,
        linux-kernel@vger.kernel.org
Subject: Re: EXT2-fs error
In-Reply-To: <E14WNrA-0006vM-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > Possibly the result of the 'silent' bug in 2.4.1?
> >
> > you are not the only one who found this bug. immediately after booting 2.4.2 i
> > received dozens of these errors, resulting in _major_ filesystem corruption.
> > after a half hour of fsck'ing i managed to bring the machine back into a usable
> 
> Had you been running 2.4.1 before that ?

I have seen similar problems on stock 2.4.2 a machine which has not run
2.4.1.

ael
-- 
Dr A E Lawrence
