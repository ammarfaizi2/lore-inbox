Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282205AbRK2AHn>; Wed, 28 Nov 2001 19:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282209AbRK2AHX>; Wed, 28 Nov 2001 19:07:23 -0500
Received: from zero.tech9.net ([209.61.188.187]:50186 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282216AbRK2AHS>;
	Wed, 28 Nov 2001 19:07:18 -0500
Subject: Re: Linux 2.4.17-pre1
From: Robert Love <rml@tech9.net>
To: Mark Hymers <markh@linuxfromscratch.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011129000509.A1362@markcomp.blaydon.hymers.org.uk>
In-Reply-To: <E169EIY-0006UI-00@the-village.bc.nu>
	<1006991294.813.0.camel@phantasy> 
	<20011129000509.A1362@markcomp.blaydon.hymers.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 28 Nov 2001 19:06:57 -0500
Message-Id: <1006992428.13159.8.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 19:05, Mark Hymers wrote:

> Do you know what the legal status of the rest of the *.c files in fs/nls
> is?  There are still quite a few which have no MODULE_LICENSE tag at all
> which causes the kernel to be tainted (IMO) incorrectly.

I believe all the fs/nls files are GPL or Dual GPL/something else.

	Robert Love

