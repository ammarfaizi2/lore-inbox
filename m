Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVCZVgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVCZVgz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 16:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261298AbVCZVgz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 16:36:55 -0500
Received: from box3.punkt.pl ([217.8.180.76]:29196 "HELO box.punkt.pl")
	by vger.kernel.org with SMTP id S261274AbVCZVgy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 16:36:54 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] linux-libc-headers 2.6.11.2
Date: Sat, 26 Mar 2005 22:35:36 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503262235.36604.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
Changes:
- added include <asm/types.h> to lots of files

Well, I could've figured out that my test scripts won't catch problems 
introduced by forcing usage of types from {linux,asm}/types.h, but I had to 
stumble across such a bug to get the idea. One way or the other, I hope 
that's fixed.


Happy Easter.

-- 
In the year eighty five ten
God is gonna shake his mighty head
He'll either say,
"I'm pleased where man has been"
Or tear it down, and start again
