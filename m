Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129685AbQLLUug>; Tue, 12 Dec 2000 15:50:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129675AbQLLUuQ>; Tue, 12 Dec 2000 15:50:16 -0500
Received: from mail1.rdc3.on.home.com ([24.2.9.40]:63429 "EHLO
	mail1.rdc3.on.home.com") by vger.kernel.org with ESMTP
	id <S129518AbQLLUuN>; Tue, 12 Dec 2000 15:50:13 -0500
Message-ID: <3A36885D.C88D8B9A@home.com>
Date: Tue, 12 Dec 2000 15:19:41 -0500
From: John Cavan <johncavan@home.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: " Paul C. Nendick" <pauly@enteract.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.2.16 SMP: mtrr errors
In-Reply-To: <20001211140029.A828@thefunk.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> kernel: mtrr: base(0xd4000000) is not aligned on a size(0x1800000) boundary
> last message repeated 2 times
> 
> and finally:
> 
> %cat /proc/mtrr
> reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> reg01: base=0xd0000000 (3328MB), size=  64MB: write-combining, count=1
> reg02: base=0xd5800000 (3416MB), size=   8MB: write-combining, count=1

I'm seeing the same thing with the Matrox G400.

John
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
