Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271899AbRHUXdG>; Tue, 21 Aug 2001 19:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271898AbRHUXc4>; Tue, 21 Aug 2001 19:32:56 -0400
Received: from sweetums.bluetronic.net ([24.162.254.3]:3765 "EHLO
	sweetums.bluetronic.net") by vger.kernel.org with ESMTP
	id <S271895AbRHUXcp>; Tue, 21 Aug 2001 19:32:45 -0400
Date: Tue, 21 Aug 2001 19:32:56 -0400 (EDT)
From: Ricky Beam <jfbeam@bluetopia.net>
X-X-Sender: <jfbeam@sweetums.bluetronic.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Qlogic/FC firmware
In-Reply-To: <E15ZKNa-0000UE-00@the-village.bc.nu>
Message-ID: <Pine.GSO.4.33.0108211927570.6389-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Aug 2001, Alan Cox wrote:
>Look, if its not distributable then its no good to anyone.

Who said it wasn't distributable?  The license in the 2.4.5 file doesn't say
you cannot distribute it.  It doesn't even prevent you from sell it.  You have
to leave the notice intact and not use it as a means to attach the Qlogic
mark to any derived product.

Other than it's age, I see *zero* reason to remove it from the tree.

>Well maybe, and whats the right way to do that, oh my god I do believe its
>an initrd.

__init_data

--Ricky


