Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316182AbSGIQLo>; Tue, 9 Jul 2002 12:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316199AbSGIQLn>; Tue, 9 Jul 2002 12:11:43 -0400
Received: from 62-190-219-220.pdu.pipex.net ([62.190.219.220]:22788 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S316182AbSGIQLn>; Tue, 9 Jul 2002 12:11:43 -0400
Date: Tue, 9 Jul 2002 17:19:28 +0100
From: jbradford@dial.pipex.com
Message-Id: <200207091619.RAA00228@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: Recoverable RAM Disk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wondering - has anyone ever given any thought to the idea of a RAM disk that is not erased on a warm boot?

Obviously this is a bit architechture-specific - I don't think it's easily do-able on i386, but maybe it is other architechtures?

The idea of a recoverable, (even bootable), RAM disk was common on the Amiga, and it would be useful to, E.G. quickly re-boot in to several different kernels.

John.
