Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312417AbSDBAih>; Mon, 1 Apr 2002 19:38:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311879AbSDBAi0>; Mon, 1 Apr 2002 19:38:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:7692 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S293119AbSDBAiT>; Mon, 1 Apr 2002 19:38:19 -0500
Date: Mon, 1 Apr 2002 20:33:30 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Dennis Vadura <dvadura@wticorp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre5 ext2/3 unmount bug
In-Reply-To: <3CA81600.7827A9FD@wticorp.com>
Message-ID: <Pine.LNX.4.21.0204012033180.8540-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 1 Apr 2002, Dennis Vadura wrote:

> If this has already been discussed, then just ignore me, but
> 
> I have a 2.4.19-pre5 kernel with preempt-kernel and lock-break 
> patches applied.  When I unmount ext2/3 filesystems I usually 
> get a hard hang.  About the only message I get is:
> 
>   kjournald[125] exited with preempt_count 1
> 
> 2.4.19-pre4 with same set of patches does not have this behaviour.
> I'm not convinced that its confined to ext3 as unmounts of an
> ext2 /usr partition without a journal caused a hard hang as well.

Does stock 2.4.19-pre5 shows the problem?

