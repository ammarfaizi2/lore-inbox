Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277143AbRKFFZt>; Tue, 6 Nov 2001 00:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275265AbRKFFZm>; Tue, 6 Nov 2001 00:25:42 -0500
Received: from zero.tech9.net ([209.61.188.187]:29455 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S276591AbRKFFYN>;
	Tue, 6 Nov 2001 00:24:13 -0500
Subject: Re: 3.0.2 breaks linux-2.4.13-ac8 in tcp.c
From: Robert Love <rml@tech9.net>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: gcc-bugs@gcc.gnu.org, linux-kernel@vger.kernel.org
In-Reply-To: <200111060513.fA65DqZ26051@vegae.deep.net>
In-Reply-To: <200111060513.fA65DqZ26051@vegae.deep.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.100+cvs.2001.11.05.15.31 (Preview Release)
Date: 06 Nov 2001 00:24:18 -0500
Message-Id: <1005024259.1376.4.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-06 at 00:13, Samium Gromoff wrote:
>      well, not too much to add, maybe except that the RAM is ok and CPU is not
>    OC`ed...
> [...]
> tcp.c: In function `tcp_close':
> tcp.c:1978: Internal compiler error in rtx_equal_for_memref_p, at alias.c:1121
> Please submit a full bug report,
> with preprocessed source if appropriate.
> See <URL:http://www.gnu.org/software/gcc/bugs.html> for instructions.

This is the GCC team's worry -- it is an internal GCC bug.  Send them
the compile log and the source file in question.

See http://www.gnu.org/software/gcc/bugs.html

	Robert Love

