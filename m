Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSJPXSJ>; Wed, 16 Oct 2002 19:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261515AbSJPXSI>; Wed, 16 Oct 2002 19:18:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:34741 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261505AbSJPXSH>;
	Wed, 16 Oct 2002 19:18:07 -0400
Date: Wed, 16 Oct 2002 16:16:43 -0700 (PDT)
Message-Id: <20021016.161643.30198311.davem@redhat.com>
To: arashi@arashi.yi.org
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AFS compile breakage in 2.5.43
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021016180350.52bc09ad.arashi@arashi.yi.org>
References: <20021016180350.52bc09ad.arashi@arashi.yi.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matt Reppert <arashi@arashi.yi.org>
   Date: Wed, 16 Oct 2002 18:03:50 -0500

   Is this valid? gcc-2.95.3 doesn't like it at all.
   [fs/afs/dir.c line 65]

David has patches coming to fix this.

It is valid, but only in newer versions of gcc.

