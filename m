Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273883AbRJDM0a>; Thu, 4 Oct 2001 08:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273893AbRJDM0U>; Thu, 4 Oct 2001 08:26:20 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:5387 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id <S273883AbRJDM0C>; Thu, 4 Oct 2001 08:26:02 -0400
From: Norbert Preining <preining@logic.at>
Date: Thu, 4 Oct 2001 14:26:24 +0200
To: Linux kernel list <linux-kernel@vger.kernel.org>
Subject: bootp problems with 2.4.10?
Message-ID: <20011004142624.F28591@alpha.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have some diskless clients whic I want to boot via bootp and nfsroot.
The kernel is loaded fro tftpboot with the option ip=bootp and tries
to find the configuration, the server sends out the informations but
the kernel does not react. I checked the communication with tcpdump
and it looks ok, but 2.4.10 does not get the ip-data.

Is this a known problem?


PS: Please respond by email too, thanks a lot.

Best wishes

Norbert

-----------------------------------------------------------------------
Norbert Preining <preining@logic.at> 
University of Technology Vienna, Austria            gpg DSA: 0x09C5B094
-----------------------------------------------------------------------
WRABNESS (n.)

The feeling after having tried to dry oneself with a damp towel.

			--- Douglas Adams, The Meaning of Liff 
