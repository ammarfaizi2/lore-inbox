Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314215AbSDVPJB>; Mon, 22 Apr 2002 11:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314216AbSDVPJA>; Mon, 22 Apr 2002 11:09:00 -0400
Received: from lucy.ulatina.ac.cr ([163.178.60.3]:3334 "EHLO
	lucy.ulatina.ac.cr") by vger.kernel.org with ESMTP
	id <S314215AbSDVPI7>; Mon, 22 Apr 2002 11:08:59 -0400
Subject: Re: Adding snapshot capability to Linux
From: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>
To: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020422124244.GA18252@spaans.ds9a.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 22 Apr 2002 09:02:35 -0600
Message-Id: <1019487755.31790.4.camel@lucy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm sorry to have to say this, but making snapshots of remote filesystems is
> kinda silly and impossible - if you implement it at the FS level.

FWIW, this kinda sounds like mirroring an EVMS object that is on a
remote machine[1], or the cache in CODA.

[1] Plugins for working on objetcs in a SAN or network attatched disks.

-- 
Alvaro Figueroa

