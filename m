Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281417AbRKMHqG>; Tue, 13 Nov 2001 02:46:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281416AbRKMHp4>; Tue, 13 Nov 2001 02:45:56 -0500
Received: from auucp0.ams.ops.eu.uu.net ([195.129.70.39]:35465 "EHLO
	auucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S281417AbRKMHpo>; Tue, 13 Nov 2001 02:45:44 -0500
Date: Tue, 13 Nov 2001 08:44:13 +0100 (CET)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: report: tun device
Message-ID: <Pine.LNX.4.33.0111130840570.16711-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I have build 2.4.15pre3 but stil can't use /dev/net/tun (vtund).

from logfile:

Nov 13 08:38:29 schoen3 vtund[16676]: Session merin[xxx.xxx.xxx.xxx:1402]
opened
Nov 13 08:38:29 schoen3 vtund[16676]: Can't allocate tun device. File
descriptorNov 13 08:38:29 schoen3 vtund[16676]: Session merin closed
Nov 13 08:38:35 schoen3 vtund[16677]: Session merin[xxx.xxx.xxx.xxx:1403]
opened
Nov 13 08:38:35 schoen3 vtund[16677]: Can't allocate tun device. File
descriptorNov 13 08:38:35 schoen3 vtund[16677]: Session merin closed

kees

