Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279636AbRJXXVL>; Wed, 24 Oct 2001 19:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279639AbRJXXVA>; Wed, 24 Oct 2001 19:21:00 -0400
Received: from a5196.upc-a.chello.nl ([62.163.5.196]:54791 "EHLO zeus")
	by vger.kernel.org with ESMTP id <S279636AbRJXXUu>;
	Wed, 24 Oct 2001 19:20:50 -0400
Message-ID: <005001c15ce2$1123aec0$0500a8c0@brekoo.noip.com>
From: "Marc Brekoo" <kernel@brekoo.no-ip.com>
To: =?iso-8859-1?Q?Mart=EDn_Marqu=E9s?= <martin@bugs.unl.edu.ar>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20011024214017.E5B1D2AB49@bugs.unl.edu.ar>
Subject: Re: howto see shmem
Date: Thu, 25 Oct 2001 01:17:34 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>I have found out that /proc/meminfo doesn't have (at least that's my first
>thought) info about shared memory (it shows 0, even in heavy duty servers).
>ipcs also shows nothing, so how can I see the amount of shared memory being
>used?
>Th mounted /dev/shmem device also shows 0 kb used (just in case).

AFAIK you can't. Calculating how much shared mem is used in 2.4.x is just
too hard...

Greets,
Marc.


