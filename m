Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280945AbRKLTSa>; Mon, 12 Nov 2001 14:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280944AbRKLTRz>; Mon, 12 Nov 2001 14:17:55 -0500
Received: from imap.digitalme.com ([193.97.97.75]:3779 "EHLO digitalme.com")
	by vger.kernel.org with ESMTP id <S280941AbRKLTRh>;
	Mon, 12 Nov 2001 14:17:37 -0500
Subject: Re: Linux 2.4.15-pre4 - merge with Alan
From: "Trever L. Adams" <vichu@digitalme.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0111121056260.1078-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.11.08.57 (Preview Release)
Date: 12 Nov 2001 14:18:03 -0500
Message-Id: <1005592689.1273.11.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Red Hat mounts /dev/shm as tmpfs instead of shmfs.  From what I can tell
this is accurate.  However since the beginning of the new VM, it seems
that shmfs/tmpfs leaks memory.

I am just curious about how I can look into this so that I can ease my
mind as well as anyone else who notices this.

Trever


