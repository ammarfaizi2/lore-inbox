Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312357AbSCYIdG>; Mon, 25 Mar 2002 03:33:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312356AbSCYIc4>; Mon, 25 Mar 2002 03:32:56 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:3837 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312355AbSCYIcn>; Mon, 25 Mar 2002 03:32:43 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <5.1.0.14.2.20020325013452.03e53630@pop.cus.cam.ac.uk> 
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: ANN: New NTFS driver (2.0.0/TNG) now finished. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Mar 2002 08:32:07 +0000
Message-ID: <6451.1017045127@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


aia21@cam.ac.uk said:
>  And it should work  on both little endian and big endian
> architectures, and both on 32 and 64  bit architectures. Note, only
> ia32 has actually been tested and there may  be problems with
> architectures not supporting unaligned accesses. Any  volunteers for
> non-ia32 architectures?

All architectures should support unaligned accesses.

--
dwmw2


