Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289063AbSAGBdp>; Sun, 6 Jan 2002 20:33:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289068AbSAGBdg>; Sun, 6 Jan 2002 20:33:36 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:45784 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S289063AbSAGBdb>;
	Sun, 6 Jan 2002 20:33:31 -0500
Date: Mon, 7 Jan 2002 02:33:16 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200201070133.CAA03628@harpo.it.uu.se>
To: davidel@xmailserver.org
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre performance degradation on an old 486 )
Cc: axboe@suse.de, linux-kernel@vger.kernel.org, mjh@vr-web.de,
        torvalds@transmeta.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002 15:59:05 -0800 (PST), Davide Libenzi wrote:
>I made this patch for Andrea and it's the scheduler code for 2.4.18-pre1
>Could someone give it a try on old 486s

Done. On my '93 vintage 486, 2.4.18p1 + your scheduler results in very
bursty I/O and poor performance, just like I reported for 2.5.2-pre7.

/Mikael
