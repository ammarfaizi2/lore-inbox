Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261346AbSJUMSk>; Mon, 21 Oct 2002 08:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261347AbSJUMSk>; Mon, 21 Oct 2002 08:18:40 -0400
Received: from 62-190-219-169.pdu.pipex.net ([62.190.219.169]:64265 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261346AbSJUMSh>; Mon, 21 Oct 2002 08:18:37 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210211234.g9LCYAAf002661@darkstar.example.net>
Subject: Docs for 2.4.x -> 2.6.x
To: linux-kernel@vger.kernel.org
Date: Mon, 21 Oct 2002 13:34:10 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is anybody currently responsible for writing a 2.4.x -> 2.6.x
migration FAQ/HOWTO/guide at all?

I know, in theory, you should just be able to do a 'make oldconfig',
etc, etc, but we really want to encourage people to move from, say,
OSS to ALSA, and to start using things that were experimental in
2.4.x, but not experimental in 2.6.x

If nobody else is already responsible for making such a document, I'd
be quite interested in collecting the necessary info from the various
maintainers, and collating it in to a usable document.

I think it would be quite useful, because without such an effort, I
think that there will be quite a few 2.6.x boxen out there which are
using no new features over 2.4.x, and as a result aren't going to feel
as much of an improvement as they could do.

John.
