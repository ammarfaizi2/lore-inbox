Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRHEPwI>; Sun, 5 Aug 2001 11:52:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269969AbRHEPvt>; Sun, 5 Aug 2001 11:51:49 -0400
Received: from [193.233.7.97] ([193.233.7.97]:41222 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S269318AbRHEPvn>;
	Sun, 5 Aug 2001 11:51:43 -0400
Message-Id: <200108050204.GAA00381@mops.inr.ac.ru>
Subject: Re: tcp connection hangs on connect
To: philipp.reisner@cubit.at
Date: Sun, 5 Aug 2001 06:04:09 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010803090026.C31230@cubit.at> from "Philipp Reisner" at Aug 3, 1 11:15:00 am
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> simply hangs after some minutes to an hour. The script runs on
> a Linux-2.2.19 Box (we have also tested Linux-2.4.2)

This bug has been fixed in later 2.4s.

Corresponding fix to 2.2 is expected to be in 2.2.20 and it is available
in Alan's 2.2.20-pre.

Alexey
