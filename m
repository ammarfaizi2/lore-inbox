Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263190AbREWSAe>; Wed, 23 May 2001 14:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263191AbREWSAY>; Wed, 23 May 2001 14:00:24 -0400
Received: from smtpnotes.altec.com ([209.149.164.10]:53770 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S263190AbREWSAQ>; Wed, 23 May 2001 14:00:16 -0400
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Andries.Brouwer@cwi.nl
cc: Andries.Brouwer@cwi.nl, helgehaf@idb.hist.no, linux-kernel@vger.kernel.org
Message-ID: <86256A55.0062A9D7.00@smtpnotes.altec.com>
Date: Wed, 23 May 2001 10:24:06 -0500
Subject: Re: [PATCH] struct char_device
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org








Andries.Brouwer@cwi.nl on 05/23/2001 08:34:44 AM

To:   Andries.Brouwer@cwi.nl, helgehaf@idb.hist.no, linux-kernel@vger.kernel.org
cc:    (bcc: Wayne Brown/Corporate/Altec)

Subject:  Re: [PATCH] struct char_device



>> But I don't want an initrd.
>
>Don't be afraid of words. You wouldnt notice - it would do its
>job and disappear just like piggyback today.

So nothing in the boot scripts would have to change?  (Not that it would be a
big problem if it was necessary.  However, I prefer to keep things in /etc/rc.d
as close to the distribution defaults as possible, just in case I ever need to
reinstall the distribution.)

Wayne




