Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129251AbQKPNrh>; Thu, 16 Nov 2000 08:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbQKPNr2>; Thu, 16 Nov 2000 08:47:28 -0500
Received: from mail-out.chello.nl ([213.46.240.7]:1347 "EHLO
	amsmta04-svc.chello.nl") by vger.kernel.org with ESMTP
	id <S129251AbQKPNrN>; Thu, 16 Nov 2000 08:47:13 -0500
Date: Thu, 16 Nov 2000 15:24:58 +0100 (CET)
From: Igmar Palsenberg <maillist@chello.nl>
To: "Andreas S. Kerber" <ask@ag-trek.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Large File Support
In-Reply-To: <20001116084437.A14842@kira.in.ag-trek.de>
Message-ID: <Pine.LNX.4.21.0011161523200.2523-100000@server.serve.me.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Nov 2000, Andreas S. Kerber wrote:

> We need to handle files which are about 10GB large.
> Is there any way to do this with Linux? Some pointers would be nice.

Install a kernel / glibc that handles LFS. Search for LFS on Freshmeat,
you'll end up with the right patch.

You'll probably need to recompile some stuff, see the LFS patches on what
define to use. I forgot.

> Andreas


	Igmar

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
