Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281847AbRKRDCz>; Sat, 17 Nov 2001 22:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281848AbRKRDCp>; Sat, 17 Nov 2001 22:02:45 -0500
Received: from [208.129.208.52] ([208.129.208.52]:22020 "EHLO xmailserver.org")
	by vger.kernel.org with ESMTP id <S281847AbRKRDCg>;
	Sat, 17 Nov 2001 22:02:36 -0500
Date: Sat, 17 Nov 2001 19:11:53 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: David Sanchez <dsanchez@veloxia.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug; latest kernels with LinuxThreads
In-Reply-To: <5.1.0.14.2.20011118033452.037a5728@pop.veloxia.com>
Message-ID: <Pine.LNX.4.40.0111171855030.1011-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Nov 2001, David Sanchez wrote:

> Class is correctly allocated with "new", and also remember that the daemon
> runs without any problem and in a production environment with kernel 2.4.9
> and lowers.

Try a "p self" from frame #0




- Davide



