Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290572AbSAYGAf>; Fri, 25 Jan 2002 01:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290573AbSAYGAZ>; Fri, 25 Jan 2002 01:00:25 -0500
Received: from [204.42.16.60] ([204.42.16.60]:23302 "EHLO gerf.org")
	by vger.kernel.org with ESMTP id <S290572AbSAYGAR>;
	Fri, 25 Jan 2002 01:00:17 -0500
Date: Fri, 25 Jan 2002 00:00:16 -0600
From: The Doctor What <docwhat@gerf.org>
To: linux-kernel@vger.kernel.org
Subject: O(1) on powerpc....
Message-ID: <20020125000016.A4561@gerf.org>
Mail-Followup-To: The Doctor What <docwhat@gerf.org>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried to compile the O(1) patch on the powerpc kernel (using
BenH's latest greatest).  But it didn't work.  It puked on the
counter and processor stuff in mk_def.c:4[01] in arch/powerpc/kernel

Is this patch just incompatable with the powerpc in some way, or is
it something that hasn't been addressed because Ingo has only ia32
systems at his disposal?

Ciao!

-- 
"By the pricking of my thumbs, something wicked this way comes."
	--Shakespeare, MacBeth, IV:i

The Doctor What: Need I say more?                http://docwhat.gerf.org/
docwhat@gerf.org                                                   KF6VNC
