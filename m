Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266675AbSL3E0i>; Sun, 29 Dec 2002 23:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266676AbSL3E0i>; Sun, 29 Dec 2002 23:26:38 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:3633 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S266675AbSL3E0i>;
	Sun, 29 Dec 2002 23:26:38 -0500
Date: Sun, 29 Dec 2002 23:53:35 -0500
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.5.53-mm2 timing problems
Message-ID: <20021230045335.GA26066@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When playing netris, the shapes fall a lot faster in 2.5.53-mm2 than in 
2.4.20 and in 2.5.53.  Also, the login prompt says "login timed out
after 60 seconds" when only about 10-15 have passed.

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
