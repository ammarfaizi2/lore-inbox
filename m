Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136410AbRD2W4I>; Sun, 29 Apr 2001 18:56:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136406AbRD2Wz6>; Sun, 29 Apr 2001 18:55:58 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:37650
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S136409AbRD2Wzx>; Sun, 29 Apr 2001 18:55:53 -0400
Date: Sun, 29 Apr 2001 18:55:11 -0400
From: Chris Mason <mason@suse.com>
To: spam@perlpimp.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs autofix?
Message-ID: <621300000.988584911@tiny>
In-Reply-To: <20010429144827.A751@vancouver.yi.org>
X-Mailer: Mulberry/2.0.8 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sunday, April 29, 2001 02:48:27 PM -0700 putter <spam@perlpimp.com>
wrote:

> Hi,
> I am kernel newbie, especially with logging filesystems.
> Now I am using Mandrake 7.1 with 2.4.3 kernel and imon patch
> and NVidia drivers compiled into the kernel.
     ^^^^^^^^^^^^^^^

The binary only nvidia drivers make it a bit hard for us to debug.

> Now, all my partitions are ReiserFS. I usually play quake once
> or twice a day. Sometimes graphics subsystem freezes up, so it takes
> keyboard input. Caps and Numlock are working fine, unless I try to kill
> X with ctrlalt-backspace. So I reset my machine with hardware switch.

Check your /var/log/messages.  You probably have messages from reiserfs.
Send along an lspci so we can see what your hardware is.

-chris

