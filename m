Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319311AbSHNUr1>; Wed, 14 Aug 2002 16:47:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319319AbSHNUq4>; Wed, 14 Aug 2002 16:46:56 -0400
Received: from mail.gurulabs.com ([208.177.141.7]:21931 "HELO
	mail.gurulabs.com") by vger.kernel.org with SMTP id <S319311AbSHNUph>;
	Wed, 14 Aug 2002 16:45:37 -0400
Date: Wed, 14 Aug 2002 14:49:30 -0600 (MDT)
From: Dax Kelson <dax@gurulabs.com>
X-X-Sender: dkelson@mooru.gurulabs.com
To: torvalds@transmeta.com, "Kendrick M. Smith" <kmsmith@umich.edu>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       "nfs@lists.sourceforge.net" <nfs@lists.sourceforge.net>
Subject: Will NFSv4 be accepted?
In-Reply-To: <Pine.SOL.4.44.0208131901270.25942-100000@rastan.gpcc.itd.umich.edu>
Message-ID: <Pine.LNX.4.44.0208141435210.30333-100000@mooru.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Linus, I'm curious if the NFSv4 patches will be accepted in the near 
future (ie, before 2.6).

I for one would REALLY like to see NFSv4 (actually, Kerberized NFSv4 is 
what I'm after).   I just finished setting up a Kerberized Solaris NFS 
environment with home directories automounted from the clients with 
strong user authentication.

Frankly, the stock (non-Kerberized) NFS security model blows.

The fact that any janitor with a laptop (or any client with a malicious
root user) can nuke all home directories from a standard NFS home
directory server bothers me greatly.

Dax Kelson
Guru Labs

