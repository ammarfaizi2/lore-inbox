Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317597AbSG2CIr>; Sun, 28 Jul 2002 22:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317647AbSG2CIr>; Sun, 28 Jul 2002 22:08:47 -0400
Received: from holomorphy.com ([66.224.33.161]:34218 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317597AbSG2CIr>;
	Sun, 28 Jul 2002 22:08:47 -0400
Date: Sun, 28 Jul 2002 19:11:50 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Rik van Riel <riel@conectiva.com.br>, Andrea Arcangeli <andrea@suse.de>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729021150.GX25038@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@zip.com.au>,
	Rik van Riel <riel@conectiva.com.br>,
	Andrea Arcangeli <andrea@suse.de>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20020729005612.GM1201@dualathlon.random> <Pine.LNX.4.44L.0207282205300.3086-100000@imladris.surriel.com> <3D44A4EB.C5EE33@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <3D44A4EB.C5EE33@zip.com.au>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel wrote:
>> Together with the K42 people we found a way to avoid the
>> badnesses of an object-based VM.

On Sun, Jul 28, 2002 at 07:14:03PM -0700, Andrew Morton wrote:
> eek.  Please let's not tie the delivery of the 2.6 kernel to
> the success of this R&D effort.  We need reasonable-sized fixes, fast,
> for the current problems so that people who have feature work banked
> up can get going on it.
> Plus, staying close to the 2.4 rmap VM allows us to leverage the
> testing and experience which that has had, yes?

If this is the direction we're headed there are some tasks I won't
be able to get out of. I was ready for double and/or triple duty
anyway, though.


Cheers,
Bill
