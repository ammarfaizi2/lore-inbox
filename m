Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291876AbSBARiZ>; Fri, 1 Feb 2002 12:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291878AbSBARiP>; Fri, 1 Feb 2002 12:38:15 -0500
Received: from mail.littlefeet-inc.com ([63.215.255.3]:7438 "EHLO
	ltfsd01.little-ft.com") by vger.kernel.org with ESMTP
	id <S291876AbSBARiH>; Fri, 1 Feb 2002 12:38:07 -0500
Message-ID: <B9F49C7F90DF6C4B82991BFA8E9D547B125712@BUFORD.littlefeet-inc.com>
From: Kris Urquhart <kurquhart@littlefeet-inc.com>
To: "'Andre Hedrick'" <andre@linuxdiskcert.org>
Cc: "'Andreas Dilger'" <adilger@turbolabs.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@math.psu.edu>
Subject: RE: false positives on disk change checks
Date: Fri, 1 Feb 2002 09:33:41 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andre Hedrick [mailto:andre@linuxdiskcert.org]
> Sent: Friday, February 01,
> > 
> > Andre, looks like setup above gives false positives on disk 
> change check...
> 
> What do you expect w/ removable media.
> Obivious it has to be reporting an media status event change.
> Gawd knows where I could find a copy of the hardware to verify.
> If it puts a patch of mine on it and it is still present there is a
> problem, if it goes away with the patch, the kernel should 
> take the patch.
> 

I tried ide.2.4.17.01192002.patch, with no change.  
Is there a different patch you would like me to try?

Thanks.

-Kris
