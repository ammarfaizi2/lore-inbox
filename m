Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314601AbSD3Sc7>; Tue, 30 Apr 2002 14:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314685AbSD3Sc6>; Tue, 30 Apr 2002 14:32:58 -0400
Received: from mailsorter.ma.tmpw.net ([63.112.169.25]:16929 "EHLO
	mailsorter.ma.tmpw.net") by vger.kernel.org with ESMTP
	id <S314601AbSD3Sc5>; Tue, 30 Apr 2002 14:32:57 -0400
Message-ID: <61DB42B180EAB34E9D28346C11535A7817806A@nocmail101.ma.tmpw.net>
From: "Holzrichter, Bruce" <bruce.holzrichter@monster.com>
To: "'davem@redhat.com'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: pgtable.h in Sparc64
Date: Tue, 30 Apr 2002 13:32:44 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave,

Are you already splitting out the stuff to make a cacheflush.h and
tlbflush.h from asm-sparc64/pgtable.h?  It doesn't look to be to bad a
split, to keep the build working.  

Thanks,
Bruce H

