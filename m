Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262640AbTJGTu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 15:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262651AbTJGTu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 15:50:59 -0400
Received: from shiva.jussieu.fr ([134.157.0.129]:54542 "EHLO shiva.jussieu.fr")
	by vger.kernel.org with ESMTP id S262640AbTJGTu6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 15:50:58 -0400
To: linux-kernel@vger.kernel.org
Subject: MCE: The hardware reports... (AMD Duron)
From: Juliusz Chroboczek <jch@pps.jussieu.fr>
Date: 07 Oct 2003 21:50:57 +0200
Message-ID: <tppth8j07y.fsf@helium.pps.jussieu.fr>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Antivirus: scanned by sophie at shiva.jussieu.fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Under both 2.6.0test4 and test6, I'm fairly regularly getting the
following at boot time:

 MCE: The hardware reports a non fatal, correctable incident occurred on CPU 0.
 Bank 0: e603800000000175

The machine is a Compaq Presario 711, with a 950MHz Mobile Duron
(family 6 model 7 stepping 1 according to /proc/cpuinfo).

The Intel docs seem to imply that this is something memory-related, I
couldn't find the relevant AMD docs.

Would somebody be so kind as to explain what the above means?

Thanks,

                                        Juliusz Chroboczek

P.S. I will try to check the list archives, but would appreciate it if
     you could CC me with any reply.
