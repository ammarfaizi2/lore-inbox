Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269980AbRHJTaB>; Fri, 10 Aug 2001 15:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269987AbRHJT3w>; Fri, 10 Aug 2001 15:29:52 -0400
Received: from nic-163-c160-146.mn.mediaone.net ([24.163.160.146]:12416 "EHLO
	tweety.localdomain") by vger.kernel.org with ESMTP
	id <S269980AbRHJT3l>; Fri, 10 Aug 2001 15:29:41 -0400
Date: Fri, 10 Aug 2001 14:29:32 -0500 (CDT)
From: "Scott M. Hoffman" <scott1021@mediaone.net>
X-X-Sender: <scott@tweety.localdomain>
Reply-To: <scott1021@mediaone.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.7-ac10
In-Reply-To: <E15VC1V-0000wO-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0108101423220.1544-100000@tweety.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Aug 2001 at 14:08 +0100 Alan Cox wrote:

> >   Linus' pre8 patch fixes it, but then I was unable to get the ext3 patch
>
> Umm Linus tree only has DRM 4.1 ?
>

Well, I originally did say that I was confused. I understand that some
would like to have the 4.0 as well as the 4.1 option, but with having both
options, I had wondered if the 4.0 code was interferring with the 4.1 code
and causing my segfaults.
 Anyway, with ac11 I still get segfaults trying to glxinfo or glxgears.


Scott Hoffman


