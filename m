Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284248AbRLLAOQ>; Tue, 11 Dec 2001 19:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284245AbRLLAOG>; Tue, 11 Dec 2001 19:14:06 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:54268 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284243AbRLLANs>; Tue, 11 Dec 2001 19:13:48 -0500
Date: Tue, 11 Dec 2001 19:13:48 -0500 (EST)
From: Elliot Lee <sopwith@redhat.com>
X-X-Sender: <sopwith@devserv.devel.redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: knfsd and FS_REQUIRES_DEV
Message-ID: <Pine.LNX.4.33.0112111810160.541-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for information on knfsd's requirement that a filesystem be
FS_REQUIRES_DEV in order to export it. Would someone point me in the right
direction?

Needing to implement some not-quite-kosher exports,
-- Elliot

