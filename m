Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263452AbUDPQhR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 12:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUDPQhB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 12:37:01 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:14465
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S263452AbUDPQgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 12:36:37 -0400
Subject: Re: NFS_ALL patchsets updated for Linux-2.4.26...
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: knobi@knobisoft.de
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040416110655.38439.qmail@web13907.mail.yahoo.com>
References: <20040416110655.38439.qmail@web13907.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1082133386.2581.64.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 16 Apr 2004 09:36:26 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-04-16 at 04:06, Martin Knoblauch wrote:

>  thanks for doing that update. Short qquestion: what happened to the
> following two patches from the 2.4.23-rc1 set?
> 
> 02-fix_commit - Patch is not marked "R", but all hunks fail.

See the 2.4.26 changelog. This patch is already in the main tree.

> 06-fix_unlink - still applies (with offset) to 2.4.26

Whoops. I missed that one... I thought I'd sent it in too, but
apparently not.

I'll update the NFS_ALL...

Cheers,
  Trond
