Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266295AbSKZJE4>; Tue, 26 Nov 2002 04:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266297AbSKZJE4>; Tue, 26 Nov 2002 04:04:56 -0500
Received: from leon.mat.uni.torun.pl ([158.75.2.17]:37281 "EHLO
	Leon.mat.uni.torun.pl") by vger.kernel.org with ESMTP
	id <S266295AbSKZJE4>; Tue, 26 Nov 2002 04:04:56 -0500
Date: Tue, 26 Nov 2002 10:12:04 +0100 (CET)
From: Michal Wronski <wrona@mat.uni.torun.pl>
X-X-Sender: wrona@Juliusz
To: linux-kernel@vger.kernel.org
cc: Peter Waechtler <pwaechtler@mac.com>
Subject: Re: [PATCH] unified SysV and POSIX mqueues - complete rewrite
In-Reply-To: <Pine.LNX.4.44.0211241251320.4806-100000@Leon>
Message-ID: <Pine.GSO.4.40.0211261010020.24735-100000@Juliusz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have a few remarks/questions:

1. I can't find unregister_filesystem in your patch
2. You have different MQ_PRIO_MAX in library and patch.
3. Does mq_unlink work in a proper way?

Michal Wronski

