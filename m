Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279454AbRKFOGE>; Tue, 6 Nov 2001 09:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279412AbRKFOFy>; Tue, 6 Nov 2001 09:05:54 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:31241 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279382AbRKFOFm>; Tue, 6 Nov 2001 09:05:42 -0500
Subject: Re: another 2.4.12 + aacraid + SuSE failure.
To: Steve_Boley@Dell.com
Date: Tue, 6 Nov 2001 14:11:53 +0000 (GMT)
Cc: c.pascoe@itee.uq.edu.au, hvisage@is.co.za,
        ext2-devel@lists.sourceforge.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, Matt_Domsch@Dell.com,
        Michael_E_Brown@Dell.com
In-Reply-To: <2FE007705F88044F8B2866EB5AB86070012D6292@ausxmrr803.aus.amer.dell.com> from "Steve_Boley@Dell.com" at Nov 06, 2001 07:56:54 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1616xF-0000cG-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'll perhaps have to try the -ac patches then ...

The only real -ac change (now in Linus tree too) is that we scan > lun 0-7
on SCSI 3 devices
