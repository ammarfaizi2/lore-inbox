Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129572AbQK3PbS>; Thu, 30 Nov 2000 10:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129423AbQK3PbI>; Thu, 30 Nov 2000 10:31:08 -0500
Received: from max5.rrze.uni-erlangen.de ([131.188.3.50]:32904 "EHLO
        max5.rrze.uni-erlangen.de") by vger.kernel.org with ESMTP
        id <S129345AbQK3PbA>; Thu, 30 Nov 2000 10:31:00 -0500
Date: Thu, 30 Nov 2000 16:05:51 +0100 (MET)
From: Gunter Königsmann 
        <Gunter.B.C.Koenigsmann@e-technik.stud.uni-erlangen.de>
Reply-To: Gunter Königsmann <gunter.koenigsmann@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.2.17, makefile bug
Message-Id: <Pine.LNX.4.21.0011301602080.617-100000@calcula.uni-erlangen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello, there!


Everything works just fine, but 

'make bzlilo'


compiles the kernel, and runs lilo, but it fails to copy it to
/boot/vmlinuz before that.


Thanks,


Gunter.

-- 
If you go parachuting, and your parachute doesn't open, and your friends are
all watching you fall, I think a funny gag would be to pretend you were
swimming.
                -- Jack Handley

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
