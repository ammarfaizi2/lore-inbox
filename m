Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316630AbSEVSPi>; Wed, 22 May 2002 14:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316632AbSEVSPh>; Wed, 22 May 2002 14:15:37 -0400
Received: from 178.230.13.217.in-addr.dgcsystems.net ([217.13.230.178]:13264
	"EHLO yxa.extundo.com") by vger.kernel.org with ESMTP
	id <S316630AbSEVSPh>; Wed, 22 May 2002 14:15:37 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix complete freeze on Dell latitude in nm256_audio.c
In-Reply-To: <E17Aaee-0002Sj-00@the-village.bc.nu>
From: Simon Josefsson <jas@extundo.com>
Date: Wed, 22 May 2002 20:12:27 +0200
Message-ID: <iluit5gt5kk.fsf@latte.josefsson.org>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Please add this to the 2.4 tree.  Without it, Dell Latitude laptops
>> completely freeze when loading the module.  Thanks.
>
> The change below has been in the tree for a while already

I only checked the latest release, not the patches.  Ok, thanks!

