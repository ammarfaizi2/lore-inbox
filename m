Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318228AbSHDUrp>; Sun, 4 Aug 2002 16:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSHDUrp>; Sun, 4 Aug 2002 16:47:45 -0400
Received: from 62-190-217-88.pdu.pipex.net ([62.190.217.88]:39684 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S318228AbSHDUrp>; Sun, 4 Aug 2002 16:47:45 -0400
Date: Sun, 4 Aug 2002 21:57:28 +0100
From: jbradford@dial.pipex.com
Message-Id: <200208042057.g74KvS3X000703@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.19 duplicate config entry
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just noticed in 2.4.19, that:

"Support for PCMCIA management for PC-style ports" appears twice in the configuration.

I didn't notice it in 2.4.19-RC2, (the last version I compiled), but I might have missed it.

By the way, I got a 2.4.18 tree, patched it to RC1, then used the incremental patches up to -final.

The second instance is greyed-out in xconfig, and neither allows y, m or n to be selected.

John.
