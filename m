Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264956AbSKFKu1>; Wed, 6 Nov 2002 05:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264958AbSKFKu1>; Wed, 6 Nov 2002 05:50:27 -0500
Received: from amigo.dent.med.uni-muenchen.de ([138.245.179.32]:36460 "EHLO
	amigo.dent.med.uni-muenchen.de") by vger.kernel.org with ESMTP
	id <S264956AbSKFKu0>; Wed, 6 Nov 2002 05:50:26 -0500
Date: Wed, 6 Nov 2002 11:57:01 +0100 ("MET)
Message-Id: <200211061057.LAA89915@max.zk-i.med.uni-muenchen.de>
From: Wolfram Gloger <Wolfram.Gloger@dent.med.uni-muenchen.de>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at inode.c:1034!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please try 2.4.20-pre11 or later.  I believe this is the usbfs race
that has already been fixed.

Regards,
Wolfram.
