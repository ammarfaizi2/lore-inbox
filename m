Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278306AbRJMOqj>; Sat, 13 Oct 2001 10:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278307AbRJMOqa>; Sat, 13 Oct 2001 10:46:30 -0400
Received: from ausxc07.us.dell.com ([143.166.99.215]:38277 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S278306AbRJMOq0>; Sat, 13 Oct 2001 10:46:26 -0400
Message-ID: <71714C04806CD51193520090272892178BD70E@ausxmrr502.us.dell.com>
From: Matt_Domsch@Dell.com
To: jhingber@ix.netcom.com, linux-kernel@vger.kernel.org
Subject: RE: ServerWorks LE MTRR's disabled?
Date: Sat, 13 Oct 2001 09:46:50 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 	MTRR's for ServerWorks LE chipsets are disabled in
> arch/i386/kernel/mtrr.c.  What particular problem does this chipset
> have?  I have a revision 5 board which does infact work properly with
> MTRR's.  The system is an IBM NetFinity 5600 with 2 PIII's 800's.  Is
> this problem dependant on certain board/configurations?  If so, might
> there be a better workaround than disabling MTRR entirely?

There was some speculation that LE rev. 5 chips don't have a problem, but no
definitive answer from ServrWorks yet that I'm aware of.


-- 
Matt Domsch
Sr. Software Engineer
Dell Linux Solutions
www.dell.com/linux
#2 Linux Server provider with 17% in the US and 14% Worldwide (IDC)!
#3 Unix provider with 18% in the US (Dataquest)!
