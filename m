Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129752AbQLWSOL>; Sat, 23 Dec 2000 13:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130375AbQLWSOB>; Sat, 23 Dec 2000 13:14:01 -0500
Received: from open.your.mind.be ([195.162.205.66]:48119 "HELO
	portablue.intern.mind.be") by vger.kernel.org with SMTP
	id <S129752AbQLWSNt>; Sat, 23 Dec 2000 13:13:49 -0500
Date: Sat, 23 Dec 2000 18:43:03 +0100
To: linux-kernel@vger.kernel.org
Subject: 2.4.0-test12 on Miata
Message-ID: <20001223184303.M792@mind.be>
Mail-Followup-To: p2@mind.be, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Answer: 42
X-Operating-system: Debian GNU/Linux
From: p2@mind.be (Peter De Schrijver)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Compiling 2.4.0-test12 for the Miata Alpha platform seems to result in a kernel
which does not correctly handle (or initialize ?) ISA IRQ's. The result is that
ps/2 keyboard and mouse and floppy don't work. I didn't check if the serial or
parallel ports work. Compiling 2.4.0-test12 for the generic Alpha platform does
work. Any ideas or insights ?

Thanks,

Peter.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
