Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263420AbSJCLJk>; Thu, 3 Oct 2002 07:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263421AbSJCLJk>; Thu, 3 Oct 2002 07:09:40 -0400
Received: from 62-190-201-39.pdu.pipex.net ([62.190.201.39]:1284 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263419AbSJCLJj>; Thu, 3 Oct 2002 07:09:39 -0400
Date: Thu, 3 Oct 2002 12:20:21 +0100
From: jbradford@dial.pipex.com
Message-Id: <200210031120.g93BKLqK000216@darkstar.example.net>
To: roy@karlsbakk.net
Subject: RAID backup
Cc: jakob@unthought.net, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Might it not be a good idea to DD the raw contents of each disk to a tape drive, just incase you fubar the array?  It would be time consuming, but at least you could restore your data in the event that it gets corrupted.

John.
