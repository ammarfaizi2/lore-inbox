Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264573AbRFZL1C>; Tue, 26 Jun 2001 07:27:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264600AbRFZL0x>; Tue, 26 Jun 2001 07:26:53 -0400
Received: from serwer.osi.gda.pl ([213.25.180.210]:43528 "EHLO lite.osi.gda.pl")
	by vger.kernel.org with ESMTP id <S264573AbRFZL0e>;
	Tue, 26 Jun 2001 07:26:34 -0400
To: linux-kernel@vger.kernel.org
Subject: 2.2.19 and grow_inodes: allocation failed
From: klakier@pld.org.pl (=?iso-8859-2?q?Rafa=B3?= Kleger-Rudomin)
Date: 26 Jun 2001 13:23:48 +0200
Message-ID: <m3r8w7pjqz.fsf@zolw.dom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Bryce Canyon)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello!

I get 'grow_inodes: allocation failed' during installation
of dev*rpm package.

I've found archive thread about inode leakage in 2.2.6 and 2.2.13
but I couldn't find whether this has been fixed in later
kernels.

Is it possible that I have the same problem in 2.2.19?

Regards,
Rafal

-- 
Rafa³ Kleger-Rudomin (klakier@pld.org.pl)
