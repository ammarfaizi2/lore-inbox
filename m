Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263574AbRFNSE5>; Thu, 14 Jun 2001 14:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263584AbRFNSEw>; Thu, 14 Jun 2001 14:04:52 -0400
Received: from dc-mx03.cluster0.hsacorp.net ([209.225.8.13]:54922 "EHLO
	dc-mx03.cluster1.charter.net") by vger.kernel.org with ESMTP
	id <S263574AbRFNSE0>; Thu, 14 Jun 2001 14:04:26 -0400
Content-Type: text/plain; charset=US-ASCII
From: Cory Watson <gphat@cafes.net>
To: David Monniaux <monniaux_nospam@arbouse.ens.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: more on VIA 686B (trials)
Date: Thu, 14 Jun 2001 13:11:13 -0500
X-Mailer: KMail [version 1.2]
In-Reply-To: <20010614194402.A19960@picsou.chatons>
In-Reply-To: <20010614194402.A19960@picsou.chatons>
MIME-Version: 1.0
Message-Id: <01061413111300.06452@achmed>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 14 June 2001 12:44 pm, David Monniaux wrote:
> So we have two kinds of problems:
> - *certain* 686B motherboards crash if used with an Athlon kernel
>   (and it does not depend on the compiler options, rather on hand-made
>   Athlon optimizations)

Abit KT7A, kernel oops right after boot... :(  Can be solved to turning off 
'Enhance Chip Performance' in the BIOS, but then our chip performance is 
un'Enhance'd, and we can't have that!  So back to the K6 kernel.

-- 
Cory 'G' Watson
   Dad are you vicariously living through me in the hope that my
accomplishments will validate your mediocre life and in some way compensate 
for
all the opportunities you botched ?	  -- Calvin
