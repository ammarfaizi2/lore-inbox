Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261587AbSJURdf>; Mon, 21 Oct 2002 13:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261593AbSJURdf>; Mon, 21 Oct 2002 13:33:35 -0400
Received: from mimas.island.net ([199.60.19.4]:4626 "EHLO mimas.island.net")
	by vger.kernel.org with ESMTP id <S261587AbSJURde>;
	Mon, 21 Oct 2002 13:33:34 -0400
Date: Mon, 21 Oct 2002 10:39:38 -0700 (PDT)
From: andy barlak <andyb@island.net>
Reply-To: <andyb@island.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi_error device offline fix
Message-ID: <Pine.LNX.4.30.0210211036010.21364-100000@tosko.alm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch to scsi_error.c   make no improvement
in my BusLogic 958  difficulties.  Still get these messages
and timouts with the patch.

scsi_eh_offline_sdevs: Device offlined - not ready or command retry failed after
 error recovery: host 0 channel 0 id 1 lun 0
.
.
.

-- 

 Andy Barlak

