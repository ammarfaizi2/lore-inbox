Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266210AbSKSO0Y>; Tue, 19 Nov 2002 09:26:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266240AbSKSO0Y>; Tue, 19 Nov 2002 09:26:24 -0500
Received: from ool-4353bc1c.dyn.optonline.net ([67.83.188.28]:34392 "EHLO
	dps7.oconnoronline.net") by vger.kernel.org with ESMTP
	id <S266210AbSKSO0X>; Tue, 19 Nov 2002 09:26:23 -0500
References: <3DDA4921.30403@oracle.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
In-Reply-To: <3DDA4921.30403@oracle.com> (message from Alessandro Suardi on Tue, 19 Nov 2002 15:22:25 +0100)
To: alessandro.suardi@oracle.com
Subject: Re: Oracle 9.2 OOMs again at startup in 2.5.4[78]
From: "Billy O'Connor" <billy@oconnoronline.net>
Date: 19 Nov 2002 09:34:49 -0500
Message-ID: <84vg2t39x2.fsf@dps7.oconnoronline.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 ...just like it did a few kernels ago (the current->mm issue in 2.5.19
   that eventually got fixed in 2.5.30 or thereabouts, introduced for the
   bk-enabled by cset 1.373.221.1).
 
 I'll go building a 2.5.44 kernel (think it's the only one I didn't have
   too much trouble building / booting in the 2.5.4x series before .47)
   and see whether it works or not.

I'd like to try to reproduce this, Alessandro.  Could you forward me
the other details about the server you're experiencing the problem on?

Billy O'Connor
