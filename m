Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133088AbRDRLl1>; Wed, 18 Apr 2001 07:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133089AbRDRLlR>; Wed, 18 Apr 2001 07:41:17 -0400
Received: from inpbox.inp.nsk.su ([193.124.167.24]:62090 "EHLO
	inpbox.inp.nsk.su") by vger.kernel.org with ESMTP
	id <S133088AbRDRLlK>; Wed, 18 Apr 2001 07:41:10 -0400
Date: Wed, 18 Apr 2001 18:15:48 +0700
From: "Dmitry A. Fedorov" <D.A.Fedorov@inp.nsk.su>
Reply-To: D.A.Fedorov@inp.nsk.su
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Supplying missing entries for Configure.help, part 4
In-Reply-To: <200104180526.f3I5Qmr14004@snark.thyrsus.com>
Message-ID: <Pine.SGI.4.10.10104181809290.6767232-100000@Sky.inp.nsk.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Eric S. Raymond <esr@snark.thyrsus.com>
> To: Alan Cox <alan@lxorguk.ukuu.org.uk>, torvalds@transmeta.com,
     axel@uni-paderborn.de, linux-kernel@vger.kernel.org,
     kbuild-devel@lists.sourceforge.net
> Date: Wed, 18 Apr 2001 01:26:48 -0400
> Subject: Supplying missing entries for Configure.help, part 4
> 
> This patch supplies seventeen more missing entries for the
> Configure.help file, for a total of 65 so far.  It also corrects some
> places where I omitted a CONFIG_ prefix.  It should be applied after my
> previous patches 1, 2, and 3 under the same title.
> 
> --- Configure.help	2001/04/18 03:04:27	1.4
> +++ Configure.help	2001/04/18 05:23:14

> +Windows CP1251 (Bulgarian, Belarussian)

And Russian !!!


> +CONFIG_NLS_CODEPAGE_1251
> +  The Microsoft FAT file system family can deal with filenames in
> +  native language character sets. These character sets are stored in
> +  so-called DOS codepages. You need to include the appropriate
> +  codepage if you want to be able to read/write these filenames on
> +  DOS/Windows partitions correctly. This does apply to the filenames
> +  only, not to the file contents. You can include several codepages;
> +  say Y here if you want to include the DOS codepage Bulgarian and
> +  Belorussian.

