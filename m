Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312850AbSDORUV>; Mon, 15 Apr 2002 13:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312915AbSDORUU>; Mon, 15 Apr 2002 13:20:20 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:49416 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S312850AbSDORUU>;
	Mon, 15 Apr 2002 13:20:20 -0400
From: Meelis Roos <mroos@linux.ee>
To: admin@nextframe.net (Morten Helgesen), linux-kernel@vger.kernel.org
Subject: Re:  [COMMENTS IDE 2.5] - "idebus=66" in 2.5.8 results in "ide_setup: idebus=66 -- BAD OPTION"
In-Reply-To: <20020415141658.A140@sexything>
User-Agent: tin/1.5.12-20020227 ("Toxicity") (UNIX) (Linux/2.2.15 (i586))
Message-Id: <E16xA96-0002Ru-00@roos.tartu-labor>
Date: Mon, 15 Apr 2002 20:20:04 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MH> Kernel command line: BOOT_IMAGE=2.5.8-without-TCQ ro root=303 video=matrox:vesa:0x118 idebus=66 profile=2
MH> ide_setup: idebus=66
MH> ide: system bus speed 66MHz

MH> works like a charm :)

Do you really have an IDE controller that does 66 MHz PCI? What kind on IDE
controller is this?

-- 
Meelis Roos (mroos@linux.ee)
