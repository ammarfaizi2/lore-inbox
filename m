Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292729AbSBZTVB>; Tue, 26 Feb 2002 14:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292727AbSBZTUv>; Tue, 26 Feb 2002 14:20:51 -0500
Received: from plmler5.mail.eds.com ([199.228.142.70]:36831 "EHLO
	plmler5.mail.eds.com") by vger.kernel.org with ESMTP
	id <S292729AbSBZTUn>; Tue, 26 Feb 2002 14:20:43 -0500
Message-ID: <39448DCA5614D3118C5D0008C7916DCE095DE13B@BRSPM202>
From: "Costa, Juliano" <juliano.costa@eds.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: IDE error on 2.4.17
Date: Tue, 26 Feb 2002 13:11:10 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.51)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got a similar error, in my case disk error.

-----Original Message-----
From: David Rees [mailto:dbr@greenhydrant.com]
Sent: Quarta-feira, 27 de Fevereiro de 2002 07:02
To: Linux Kernel Mailing List
Subject: Re: IDE error on 2.4.17


On Tue, Feb 26, 2002 at 06:50:15PM -0000, Simon Turvey wrote:
> The drive's less than a year old :-(
> 
> Should I try disabling some of the UDMA stuff?

Age of the disk doesn't matter, they'll die at any age.  They seem to die
most frequently either within one year, or after 3 years.

Turning off UDMA probably won't help, it looks like it's time to restore
from backups.  If you try to recover data from the disk, make sure you mount
it in read-only mode if you can get the drive that far up if you reboot.

-Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

