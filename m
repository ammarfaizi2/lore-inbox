Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284125AbRLEQRn>; Wed, 5 Dec 2001 11:17:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283786AbRLEQRi>; Wed, 5 Dec 2001 11:17:38 -0500
Received: from sun0.mpimf-heidelberg.mpg.de ([149.217.50.120]:24001 "EHLO
	sun0.mpimf-heidelberg.mpg.de") by vger.kernel.org with ESMTP
	id <S284125AbRLEQRM>; Wed, 5 Dec 2001 11:17:12 -0500
Subject: processes in uninteruptible state unkillable
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: "linux-kernel@vger" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 05 Dec 2001 17:15:48 +0100
Message-Id: <1007568949.7891.0.camel@ara>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a few processes that were started in a smb mount directory. Due
to server reboot the connection broke. The processes are now in an
uninterruptable state, waiting for IO, so, they cannot be killed nor the
smbfs unmounted.

Obviously, the only thing I can do is to reboot my computer. 
Any suggestions?

Linux ara 2.4.14 #2 Fri Nov 9 03:03:03 CET 2001 i686 unknown

Cheers.

-- 
Juergen Sawinski
Max-Planck Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-308
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 858
Mobile: +49-171-532 5302


