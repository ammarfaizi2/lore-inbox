Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280388AbRJaSaC>; Wed, 31 Oct 2001 13:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280391AbRJaS3w>; Wed, 31 Oct 2001 13:29:52 -0500
Received: from mail014.mail.bellsouth.net ([205.152.58.34]:15453 "EHLO
	imf14bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S280388AbRJaS3m>; Wed, 31 Oct 2001 13:29:42 -0500
Message-ID: <3BE04338.8F0AF9D4@mandrakesoft.com>
Date: Wed, 31 Oct 2001 13:30:16 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.14-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: pre6 BUG oops
In-Reply-To: <3BE03401.406B8585@mandrakesoft.com> <20011031.094112.125896630.davem@redhat.com> <9rpfbj$vrn$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Maybe it's just the page count that is buggered, and we free it too
> early as a result.  Is this the same machine that had interesting
> trouble before?

yes, a UP alpha running 2.4.14-pre6, that was described in the false oom
killer report.

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

