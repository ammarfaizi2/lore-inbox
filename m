Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264627AbSJ3Iy3>; Wed, 30 Oct 2002 03:54:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264628AbSJ3Iy2>; Wed, 30 Oct 2002 03:54:28 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:44716 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S264627AbSJ3Iy2>; Wed, 30 Oct 2002 03:54:28 -0500
To: andersen@codepoet.org
Cc: Dave Cinege <dcinege@psychosis.com>, Jeff Garzik <jgarzik@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Abbott and Costello meet Crunch Time -- Penultimate 2.5 merge candidate list.
References: <200210272017.56147.landley@trommello.org>
	<200210300229.44865.dcinege@psychosis.com>
	<3DBF8CD5.1030306@pobox.com>
	<200210300322.17933.dcinege@psychosis.com>
	<20021030085149.GA7919@codepoet.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Oct 2002 18:00:18 +0900
In-Reply-To: <20021030085149.GA7919@codepoet.org>
Message-ID: <buofzuogv31.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen <andersen@codepoet.org> writes:
> IMHO the embedded world (as well as everyone else) wants initramfs --
> it is a major improvement.

I guess I'm part of the `embedded world,' and I don't want _either_
because they _both use RAM_!

[Well, OK, actually it'd be nice to have something like initramfs + some
other sort of fetch-the-bits-directly-from-ROM FS which I could
mix-n-match; anyway initramfs has got to be better than initrd...]

-Miles
-- 
Love is a snowmobile racing across the tundra.  Suddenly it flips over,
pinning you underneath.  At night the ice weasels come.  --Nietzsche
