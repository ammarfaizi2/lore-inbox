Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316397AbSGAS4g>; Mon, 1 Jul 2002 14:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316404AbSGAS4f>; Mon, 1 Jul 2002 14:56:35 -0400
Received: from dingo.clsp.jhu.edu ([128.220.34.67]:24584 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S316397AbSGAS4d>;
	Mon, 1 Jul 2002 14:56:33 -0400
Date: Sun, 30 Jun 2002 23:49:35 +0200
From: Pavel Machek <pavel@ucw.cz>
To: fchabaud@free.fr
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, swsusp@lister.fornax.hu,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH][swsusp] 2.4.19-pre10-ac2
Message-ID: <20020630214935.GA103@elf.ucw.cz>
References: <200206201106.g5KB6V719618@fuji.home.perso>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200206201106.g5KB6V719618@fuji.home.perso>
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Following six patches for swsusp that were used by various people
> through swsusp list. They should apply in order to 2.4.19-pre10-ac2.
> Most of those is already in 2.5.22 suspend part managed by Pavel.

Heh, so now I'm going patch by patch to figure what to merge :-(.

> 1/6	Documentation and comments cleanings

@@ -1715,9 +1715,9 @@
 S: Germany

 N: Gabor Kuti
-E: seasons@falcon.sch.bme.hu
-E: seasons@makosteszta.sote.hu
-D: Author and Maintainer for Software Suspend
+M: seasons@falcon.sch.bme.hu
+M: seasons@makosteszta.sote.hu
+D: Software suspend

 N: Jaroslav Kysela
 E: perex@suse.cz

Why do you change E to M here?
									Pavel
-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
