Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273299AbRIRKSI>; Tue, 18 Sep 2001 06:18:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273304AbRIRKRy>; Tue, 18 Sep 2001 06:17:54 -0400
Received: from dwests3.datawest.net ([206.27.129.9]:24840 "EHLO
	dwests3.datawest.net") by vger.kernel.org with ESMTP
	id <S273299AbRIRKRf>; Tue, 18 Sep 2001 06:17:35 -0400
Subject: who writes the "disk_io:" entry in /proc/stat ?
From: Tim Sullivan <tsullivan@datawest.net>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.13 (Preview Release)
Date: 18 Sep 2001 04:18:32 -0600
Message-Id: <1000808313.1781.1.camel@prostock.ecom-tech.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

does anyone know off the top of their head which piece
of code writes the "disk_io:" entry in /proc/stat ?

I've been trying to make some sense of this entry without
much success and have so far been unsuccessful at locating
the source.

TIA
	-tim

