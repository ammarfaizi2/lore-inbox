Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131562AbRAWSvL>; Tue, 23 Jan 2001 13:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131560AbRAWSvB>; Tue, 23 Jan 2001 13:51:01 -0500
Received: from [63.109.146.2] ([63.109.146.2]:17655 "EHLO mail0.myrio.com")
	by vger.kernel.org with ESMTP id <S131559AbRAWSuu>;
	Tue, 23 Jan 2001 13:50:50 -0500
Message-ID: <4461B4112BDB2A4FB5635DE1995874320223E1@mail0.myrio.com>
From: Torrey Hoffman <torrey.hoffman@myrio.com>
To: "'Mike A. Harris'" <mharris@opensourceadvocate.org>,
        "Trever L. Adams" <trever_Adams@bigfoot.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: RE: Total loss with 2.4.0 (release) [off topic now...]
Date: Tue, 23 Jan 2001 10:50:43 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is getting off topic, but it's good to spread the info around:

Mike A. Harris (mailto:mharris@opensourceadvocate.org) said:
On Tue, 23 Jan 2001, Trever L. Adams wrote:
>I know if you have a 8G drive or larger, and install NT4 on it it
>will fry everything entirely unless you stand on your head and
>read about 50 MS kb articles.  Thankfully, I will _never_ have to
>encounter this sort of thing again though.  ;o)

If you have to share a machine with a Microsoft OS, the best thing is to
install the Microsoft OS first.  That way it can set up the partition tables
however it likes.  Just leave enough hard drive space free.  

Then install Linux.  This has several advantages - you can more easily set
up Grub or Lilo to dual boot, and Linux can deal with whatever Microsoft's
partition table flavor of the year is.  The Microsoft OS is less likely to
become confused and violently lash out using that approach :-) 

Another note: If dual-booting Windows 2000, upgrade to service pack 1 before
installing Linux.  I was able to blue-screen W2K before SP1 by starting
their disk management tool on a disk with dozens of Linux partitions.  And I
agree - I am thankful that I will never have to deal with this again either.

Torrey Hoffman
torrey.hoffman@myrio.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
