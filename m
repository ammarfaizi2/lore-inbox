Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129561AbRB0Jns>; Tue, 27 Feb 2001 04:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129625AbRB0Jnj>; Tue, 27 Feb 2001 04:43:39 -0500
Received: from louwan.lou.cbr.ru ([195.201.82.34]:41992 "HELO louwan")
	by vger.kernel.org with SMTP id <S129561AbRB0Jn0>;
	Tue, 27 Feb 2001 04:43:26 -0500
Date: Tue, 27 Feb 2001 12:41:26 +0300
From: "Dmitry B. Tsvetkov" <tdb@lou.cbr.ru>
X-Mailer: The Bat! (v1.49)
Reply-To: "Dmitry B. Tsvetkov" <tdb@lou.cbr.ru>
X-Priority: 3 (Normal)
Message-ID: <1503839065.20010227124126@lou.cbr.ru>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: frame-buffer doesn't work on HP Vectra with Matrox cards
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Summary:  frame-buffer doesn't work on HP Vectra with Matrox cards

Description:   after  switching to VGA mode all messages appeared like
dots  and  lines  over  HP  Bios  logo screen, only penguin logo looks
normal  (on  previous 2.4.0 and 2.4.1 kernels it was shown using wrong
colors or unvisible, but all fonts was shown normally).

Kernel: 2.4.2

Computers: HP Vectra VE6 series 8, Matrox G100
           HP Vectra VLi 8, Matrox G200

Linux: RedHat 7.0


