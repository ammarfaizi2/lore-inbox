Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268675AbRG3Wl5>; Mon, 30 Jul 2001 18:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268691AbRG3Wls>; Mon, 30 Jul 2001 18:41:48 -0400
Received: from mx01-a.netapp.com ([198.95.226.53]:49815 "EHLO
	mx01-a.netapp.com") by vger.kernel.org with ESMTP
	id <S268675AbRG3Wlf>; Mon, 30 Jul 2001 18:41:35 -0400
Date: Mon, 30 Jul 2001 15:41:16 -0700 (PDT)
From: Kip Macy <kmacy@netapp.com>
To: Rik van Riel <riel@conectiva.com.br>
cc: Hans Reiser <reiser@namesys.com>, Christoph Hellwig <hch@caldera.de>,
        linux-kernel@vger.kernel.org, Vitaly Fertman <vitaly@namesys.com>
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
In-Reply-To: <Pine.LNX.4.33L.0107301858350.5582-100000@duckman.distro.conectiva>
Message-ID: <Pine.GSO.4.10.10107301538410.3195-100000@orbit-fe.eng.netapp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

How does compiling in debug infrastructure protect the user's data? By
making the file system so slow that he won't use it? :-)

			-Kip

> Are you actually saying you don't care about user's data,
> or is it just my imagination ?
> 
> (I hope it's my imagination ...)
> 
> cheers,
> 
> Rik
> --
> Executive summary of a recent Microsoft press release:
>    "we are concerned about the GNU General Public License (GPL)"
> 
> 
> 		http://www.surriel.com/
> http://www.conectiva.com/	http://distro.conectiva.com/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

