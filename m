Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280228AbRJaOMQ>; Wed, 31 Oct 2001 09:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280231AbRJaOMG>; Wed, 31 Oct 2001 09:12:06 -0500
Received: from mail120.mail.bellsouth.net ([205.152.58.80]:31608 "EHLO
	imf20bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280228AbRJaOMB>; Wed, 31 Oct 2001 09:12:01 -0500
Message-ID: <3BE006D4.92E6D23A@mandrakesoft.com>
Date: Wed, 31 Oct 2001 09:12:36 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: pre6 oom killer oops
In-Reply-To: <3BE00078.FF088117@mandrakesoft.com> <3BE00202.1D530305@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

further comments #2:

when rebooting, there was some disk corruption in the ext2 filesystem.

It is my guess that this is to the large number of buffers in the vmstat
output, which I believe are dirty buffers that never got written out

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

