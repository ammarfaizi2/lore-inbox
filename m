Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbSJLQlm>; Sat, 12 Oct 2002 12:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261287AbSJLQlm>; Sat, 12 Oct 2002 12:41:42 -0400
Received: from 62-190-217-29.pdu.pipex.net ([62.190.217.29]:32267 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261286AbSJLQll>; Sat, 12 Oct 2002 12:41:41 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210121656.g9CGuT81010830@darkstar.example.net>
Subject: [new in 2.5.41] null TTY for (03:02) in tty_fasync
To: linux-kernel@vger.kernel.org
Date: Sat, 12 Oct 2002 17:56:29 +0100 (BST)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since upgrading from 2.5.40 to 2.5.41, I keep seeing:

Warning: null TTY for (03:02) in tty_fasync

in dmesg.

What is it related to?

John.
