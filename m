Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287234AbSACMwL>; Thu, 3 Jan 2002 07:52:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287248AbSACMwB>; Thu, 3 Jan 2002 07:52:01 -0500
Received: from NILE.GNAT.COM ([205.232.38.5]:29670 "HELO nile.gnat.com")
	by vger.kernel.org with SMTP id <S287244AbSACMvy>;
	Thu, 3 Jan 2002 07:51:54 -0500
From: dewar@gnat.com
To: law@redhat.com, paulus@samba.org
Subject: Re: [PATCH] C undefined behavior fix
Cc: gcc@gcc.gnu.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.linuxppc.org, trini@kernel.crashing.org,
        velco@fadata.bg
Message-Id: <20020103125151.6BF33F2E8C@nile.gnat.com>
Date: Thu,  3 Jan 2002 07:51:51 -0500 (EST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<<And before anyone says the PA is unbelievably strange and nobody else would
make the same mistakes -- the mn10300 (for which a linux port does exist)
has the same failings.
>>

Not clear these are failings, at least with respect to C, since the
addressing models are completely consistent with the C language, just
not consistent with some abuses of it.
