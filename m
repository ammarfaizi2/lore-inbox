Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279382AbRJWLkC>; Tue, 23 Oct 2001 07:40:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279386AbRJWLjx>; Tue, 23 Oct 2001 07:39:53 -0400
Received: from mail028.mail.bellsouth.net ([205.152.58.68]:28544 "EHLO
	imf28bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279383AbRJWLjj>; Tue, 23 Oct 2001 07:39:39 -0400
Message-ID: <3BD5572D.6969280B@mandrakesoft.com>
Date: Tue, 23 Oct 2001 07:40:29 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Steinmetz <ast@domdv.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext2 module build failure (2.4.13pre6)
In-Reply-To: <XFMail.20011023132048.ast@domdv.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Steinmetz wrote:
> 
> ext2 build as a module fails to missing export of generic_direct_IO which the
> attached patch fixes.
> 
> <grumble>
> posted this at 2.4.13pre2 time, now we're up to pre6 and nobody cares...
> </grumble>

Interesting considering this function does not exist at all in
2.4.13-pre6...

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

