Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSIIIOX>; Mon, 9 Sep 2002 04:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316601AbSIIIOX>; Mon, 9 Sep 2002 04:14:23 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:49566 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S315267AbSIIIOV>; Mon, 9 Sep 2002 04:14:21 -0400
Date: Mon, 9 Sep 2002 10:20:00 +0200
From: Kristian Peters <kristian.peters@korseby.net>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: linux 2.4.20-ac patches
Message-Id: <20020909102000.56e94334.kristian.peters@korseby.net>
In-Reply-To: <200209090847.32334.devilkin-lkml@blindguardian.org>
References: <200209090847.32334.devilkin-lkml@blindguardian.org>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: i686-debian-linux-gnu 2.4.19
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DevilKin <devilkin-lkml@blindguardian.org> schrieb:
> Since then if I ever attempt to access the cdrom (which is used through 
> /dev/sr1 using ide-scsi) i get an oops. After that, I get errors from the 
> SCSI layer talking about timeouts and retries.

Please have a look at the "Linux 2.4.20-pre5-ac4" thread. Exactly your problem was also noticed by 2 other people.

*Kristian

  :... [snd.science] ...:
 ::                             _o)
 :: http://www.korseby.net      /\\
 :: http://gsmp.sf.net         _\_V
  :.........................:
