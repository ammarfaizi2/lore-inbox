Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263086AbSJBOUE>; Wed, 2 Oct 2002 10:20:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263090AbSJBOUD>; Wed, 2 Oct 2002 10:20:03 -0400
Received: from 62-190-201-132.pdu.pipex.net ([62.190.201.132]:1540 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263086AbSJBOUD>; Wed, 2 Oct 2002 10:20:03 -0400
Date: Wed, 2 Oct 2002 15:33:56 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210021433.g92EXu1X000754@darkstar.example.net>
To: linux-kernel@vger.kernel.org
Subject: 2.5.40 make xconfig oddities
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Got this error on one occasion when leaving make xconfig - 'ERROR - Attempting to write value for unconfigured variable (CONFIG_BLK_DEV_IDESCSI).', but I suspect it is just a warning.

More oddly, there are two instances of 'Generic PCI IDE chipset suppport' in IDE, ATA and ATAPI Block devices.

More details on request,

John.
