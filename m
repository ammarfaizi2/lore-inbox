Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSHIUM4>; Fri, 9 Aug 2002 16:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315717AbSHIUM4>; Fri, 9 Aug 2002 16:12:56 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:12563 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S315709AbSHIUM4>;
	Fri, 9 Aug 2002 16:12:56 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200208092016.g79KGVk87834@saturn.cs.uml.edu>
Subject: Re: klibc development release
To: hpa@zytor.com (H. Peter Anvin)
Date: Fri, 9 Aug 2002 16:16:31 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <aivdi8$r2i$1@cesium.transmeta.com> from "H. Peter Anvin" at Aug 08, 2002 08:39:52 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> klibc is a tiny C library subset intended to be integrated into the
> kernel source tree and being used for initramfs stuff.  Thus,
> initramfs+rootfs can be used to move things that are currently in
> kernel space, such as ip autoconfiguration or nfsroot (in fact,
> mounting root in general) into user space.

Could I link 4-clause BSD source against this?
(the GPL is incompatible with the 4-clause BSD license)

> I would particularly appreciate portability comments, since I'm flying
> blind on non-i386 machines (anyone want to send me hardware?),
> although any bug reports would be appreciated.
>
>     ftp://ftp.kernel.org/pub/linux/libs/klibc/klibc.tar.gz
>
> I haven't bothered putting a version number on it, since it changes
> quite often.  I have also published the CVS repository in the
> directory above.

I could test on PowerPC, but wouldn't be able to tell you
if I'm testing the latest code or not. You don't need to
get creative with the version number; an integer is fine.
