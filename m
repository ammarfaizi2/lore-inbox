Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262618AbVBBUYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262618AbVBBUYY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262313AbVBBUTv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:19:51 -0500
Received: from gw.c9x.org ([213.41.131.17]:12716 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S262614AbVBBUJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:09:11 -0500
Date: Wed, 2 Feb 2005 21:08:40 +0059
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: linux-kernel@vger.kernel.org
Subject: -jedi kernel patches
Message-ID: <20050202200902.GA4860@c9x.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello,
  
  This is the unique announcement that will be sent to LKML.
  
  I'm maintaining a small patch against the -mm tree that might be useful to
other people.

  Almost every time Andrew releases a new -mm version, it brings nice bug
fixes, and it also often introduces new exciting features.

  Unfortunately, there are often nasty buglets. Like typos that prevent the
kernel from compiling, like nasty bugs that get fixed 5 minutes later with a
2-lines patch, etc.

  These buglets are fixed in the next -mm release, but since the next
release introduces new experimental stuff, it also introduces new buglets,
etc.

  The -jedi patches contains the last-minute fixes against the -mm tree.
There's no new feature here, nor new code to test. It only contains
important bug fixes that are discussed on LKML just after a new -mm release.
If you read LKML and if you're testing -mm kernels, you probably already
applied the same patches. The -jedi patch is just here to make things easier
to apply.

  In addition, it also includes the latest device-mapper updates and the
requirements for EVMS.

  The patches can be downloaded from:
  
  ftp://ftp.c9x.org/pub/linux-kernel/
  
  Mirrors are welcome.
  
      -Frank.
      
