Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267084AbTAFScH>; Mon, 6 Jan 2003 13:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbTAFScG>; Mon, 6 Jan 2003 13:32:06 -0500
Received: from mail.scs.ch ([212.254.229.5]:3742 "EHLO mail.scs.ch")
	by vger.kernel.org with ESMTP id <S267084AbTAFScG>;
	Mon, 6 Jan 2003 13:32:06 -0500
Subject: Re: [PATCH] Deprecated exec_usermodehelper, enhance
	call_usermodehelper
From: Thomas Sailer <sailer@scs.ch>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20030106053144.083C72C276@lists.samba.org>
References: <20030106053144.083C72C276@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 06 Jan 2003 19:39:48 +0100
Message-Id: <1041878388.10041.14.camel@watermelon.scs.ch>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 06:31, Rusty Russell wrote:

> OK.  This patch does that.  Thomas, Marcel, James?  This touches code
> I don't use, so although the transformation is fairly trivial...

Looks ok for me. Not tested yet, should there be any problem, I'll fix
up later. I vote for inclusion.

Tom

