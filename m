Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317708AbSHYXih>; Sun, 25 Aug 2002 19:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317742AbSHYXih>; Sun, 25 Aug 2002 19:38:37 -0400
Received: from redpine.canadian.net ([216.123.178.7]:28420 "EHLO
	redpine.canadian.net") by vger.kernel.org with ESMTP
	id <S317708AbSHYXig>; Sun, 25 Aug 2002 19:38:36 -0400
Date: Sun, 25 Aug 2002 19:42:51 -0400 (EDT)
From: Daniel Sterling <eqhmcow@lost-habit.com>
X-X-Sender: eqhmcow@redpine.canadian.net
To: linux-kernel@vger.kernel.org
Subject: scsi-idle for 2.4.19
Message-ID: <Pine.BSF.4.43L0.0208251936380.28934-100000@redpine.canadian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scsi-idle spins down and back up your scsi drives. This is updated for 2.4.19,
with an idle daemon that works. The daemon that came with 2.4.18 (from
ibiblio.org) was slightly broken.
This is a patch and a program, so here's a url:
http://www.lost-habit.com/scsi.html
-- Dan

